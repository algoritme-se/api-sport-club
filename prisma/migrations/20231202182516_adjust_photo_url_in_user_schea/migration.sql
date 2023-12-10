/*
  Warnings:

  - You are about to drop the column `email` on the `students` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `students` table. All the data in the column will be lost.
  - You are about to drop the column `photo_url` on the `students` table. All the data in the column will be lost.

*/
-- DropIndex
DROP INDEX "students_email_key";

-- AlterTable
ALTER TABLE "students" DROP COLUMN "email",
DROP COLUMN "name",
DROP COLUMN "photo_url";

-- AlterTable
ALTER TABLE "users" ALTER COLUMN "photo_url" DROP NOT NULL;
