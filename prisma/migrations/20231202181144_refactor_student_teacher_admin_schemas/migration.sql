/*
  Warnings:

  - You are about to drop the column `auth_user_id` on the `students` table. All the data in the column will be lost.
  - You are about to drop the column `auth_user_id` on the `teachers` table. All the data in the column will be lost.
  - You are about to drop the `authentication` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[user_id]` on the table `teachers` will be added. If there are existing duplicate values, this will fail.
  - Made the column `name` on table `students` required. This step will fail if there are existing NULL values in that column.
  - Made the column `address` on table `students` required. This step will fail if there are existing NULL values in that column.
  - Made the column `email` on table `students` required. This step will fail if there are existing NULL values in that column.
  - Made the column `photo_url` on table `students` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `user_id` to the `teachers` table without a default value. This is not possible if the table is not empty.

*/
-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('STUDENT', 'TEACHER', 'ADMIN');

-- CreateEnum
CREATE TYPE "StudentStatus" AS ENUM ('PENDING', 'TRIAL', 'PAID');

-- DropForeignKey
ALTER TABLE "students" DROP CONSTRAINT "students_auth_user_id_fkey";

-- DropForeignKey
ALTER TABLE "teachers" DROP CONSTRAINT "teachers_auth_user_id_fkey";

-- DropIndex
DROP INDEX "students_auth_user_id_key";

-- DropIndex
DROP INDEX "teachers_auth_user_id_key";

-- AlterTable
ALTER TABLE "students" DROP COLUMN "auth_user_id",
ADD COLUMN     "status" "StudentStatus" NOT NULL DEFAULT 'PENDING',
ALTER COLUMN "name" SET NOT NULL,
ALTER COLUMN "address" SET NOT NULL,
ALTER COLUMN "email" SET NOT NULL,
ALTER COLUMN "photo_url" SET NOT NULL;

-- AlterTable
ALTER TABLE "teachers" DROP COLUMN "auth_user_id",
ADD COLUMN     "user_id" TEXT NOT NULL;

-- DropTable
DROP TABLE "authentication";

-- DropEnum
DROP TYPE "AuthRole";

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "photo_url" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "role" "UserRole" NOT NULL DEFAULT 'STUDENT',
    "admin_id" TEXT,
    "teacherId" TEXT,
    "studentId" TEXT,
    "adminId" TEXT,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "admin_profiles" (
    "id" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,

    CONSTRAINT "admin_profiles_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "teachers_user_id_key" ON "teachers"("user_id");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "teachers"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_adminId_fkey" FOREIGN KEY ("adminId") REFERENCES "admin_profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;
