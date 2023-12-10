/*
  Warnings:

  - The values [STUDENT,TEACHER] on the enum `AuthRole` will be removed. If these variants are still used in the database, this will fail.
  - You are about to drop the column `active` on the `authentication` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `authentication` table. All the data in the column will be lost.
  - You are about to drop the column `two_fa_key` on the `authentication` table. All the data in the column will be lost.
  - You are about to drop the column `document_number` on the `students` table. All the data in the column will be lost.
  - You are about to drop the column `photoUrl` on the `students` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[document]` on the table `authentication` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `document` to the `authentication` table without a default value. This is not possible if the table is not empty.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "AuthRole_new" AS ENUM ('student', 'teacher', 'admin');
ALTER TABLE "authentication" ALTER COLUMN "role" TYPE "AuthRole_new" USING ("role"::text::"AuthRole_new");
ALTER TYPE "AuthRole" RENAME TO "AuthRole_old";
ALTER TYPE "AuthRole_new" RENAME TO "AuthRole";
DROP TYPE "AuthRole_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "students" DROP CONSTRAINT "students_modality_level_id_fkey";

-- DropForeignKey
ALTER TABLE "students" DROP CONSTRAINT "students_plan_id_fkey";

-- DropIndex
DROP INDEX "authentication_email_key";

-- AlterTable
ALTER TABLE "appointments" ALTER COLUMN "create_ad" SET DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "authentication" DROP COLUMN "active",
DROP COLUMN "email",
DROP COLUMN "two_fa_key",
ADD COLUMN     "document" TEXT NOT NULL,
ALTER COLUMN "created_at" SET DEFAULT CURRENT_TIMESTAMP,
ALTER COLUMN "updated_at" SET DEFAULT CURRENT_TIMESTAMP;

-- AlterTable
ALTER TABLE "students" DROP COLUMN "document_number",
DROP COLUMN "photoUrl",
ADD COLUMN     "photo_url" TEXT,
ALTER COLUMN "name" DROP NOT NULL,
ALTER COLUMN "address" DROP NOT NULL,
ALTER COLUMN "email" DROP NOT NULL,
ALTER COLUMN "modality_level_id" DROP NOT NULL,
ALTER COLUMN "plan_id" DROP NOT NULL;

-- AlterTable
ALTER TABLE "teachers" ADD COLUMN     "photo_url" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "authentication_document_key" ON "authentication"("document");

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_modality_level_id_fkey" FOREIGN KEY ("modality_level_id") REFERENCES "modality_levels"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "plans"("id") ON DELETE SET NULL ON UPDATE CASCADE;
