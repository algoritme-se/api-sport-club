/*
  Warnings:

  - You are about to drop the column `studentId` on the `appointments` table. All the data in the column will be lost.
  - You are about to drop the column `teacherId` on the `classes` table. All the data in the column will be lost.
  - You are about to drop the column `admin_id` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `studentId` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `teacherId` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `_ModalityToStudent` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ModalityToTeacher` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `admin_profiles` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `students` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `teachers` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[name]` on the table `modalities` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `user_id` to the `appointments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `classes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `modalities` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `modality_levels` table without a default value. This is not possible if the table is not empty.
  - Added the required column `user_id` to the `plans` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UserStatus" AS ENUM ('PENDING', 'TRIAL', 'PAID');

-- DropForeignKey
ALTER TABLE "_ModalityToStudent" DROP CONSTRAINT "_ModalityToStudent_A_fkey";

-- DropForeignKey
ALTER TABLE "_ModalityToStudent" DROP CONSTRAINT "_ModalityToStudent_B_fkey";

-- DropForeignKey
ALTER TABLE "_ModalityToTeacher" DROP CONSTRAINT "_ModalityToTeacher_A_fkey";

-- DropForeignKey
ALTER TABLE "_ModalityToTeacher" DROP CONSTRAINT "_ModalityToTeacher_B_fkey";

-- DropForeignKey
ALTER TABLE "appointments" DROP CONSTRAINT "appointments_studentId_fkey";

-- DropForeignKey
ALTER TABLE "classes" DROP CONSTRAINT "classes_teacherId_fkey";

-- DropForeignKey
ALTER TABLE "students" DROP CONSTRAINT "students_modality_level_id_fkey";

-- DropForeignKey
ALTER TABLE "students" DROP CONSTRAINT "students_plan_id_fkey";

-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_admin_id_fkey";

-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_studentId_fkey";

-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_teacherId_fkey";

-- AlterTable
ALTER TABLE "appointments" DROP COLUMN "studentId",
ADD COLUMN     "user_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "classes" DROP COLUMN "teacherId",
ADD COLUMN     "user_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "modalities" ADD COLUMN     "user_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "modality_levels" ADD COLUMN     "user_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "plans" ADD COLUMN     "user_id" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "admin_id",
DROP COLUMN "studentId",
DROP COLUMN "teacherId",
ADD COLUMN     "modality_level_id" TEXT,
ADD COLUMN     "plan_id" TEXT,
ADD COLUMN     "user_status" "UserStatus" NOT NULL DEFAULT 'TRIAL';

-- DropTable
DROP TABLE "_ModalityToStudent";

-- DropTable
DROP TABLE "_ModalityToTeacher";

-- DropTable
DROP TABLE "admin_profiles";

-- DropTable
DROP TABLE "students";

-- DropTable
DROP TABLE "teachers";

-- DropEnum
DROP TYPE "StudentStatus";

-- CreateIndex
CREATE UNIQUE INDEX "modalities_name_key" ON "modalities"("name");

-- AddForeignKey
ALTER TABLE "modalities" ADD CONSTRAINT "modalities_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "modality_levels" ADD CONSTRAINT "modality_levels_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "plans" ADD CONSTRAINT "plans_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes" ADD CONSTRAINT "classes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
