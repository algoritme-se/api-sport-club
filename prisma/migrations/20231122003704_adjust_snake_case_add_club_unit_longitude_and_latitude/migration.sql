/*
  Warnings:

  - The primary key for the `appointments` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `classId` on the `appointments` table. All the data in the column will be lost.
  - You are about to drop the column `createAd` on the `appointments` table. All the data in the column will be lost.
  - The primary key for the `authentication` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `createdAt` on the `authentication` table. All the data in the column will be lost.
  - You are about to drop the column `password` on the `authentication` table. All the data in the column will be lost.
  - You are about to drop the column `twoFaKey` on the `authentication` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `authentication` table. All the data in the column will be lost.
  - The primary key for the `classes` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `clubUnitId` on the `classes` table. All the data in the column will be lost.
  - You are about to drop the column `maximumStudents` on the `classes` table. All the data in the column will be lost.
  - You are about to drop the column `modalityId` on the `classes` table. All the data in the column will be lost.
  - You are about to drop the column `studentsBooked` on the `classes` table. All the data in the column will be lost.
  - The primary key for the `club_units` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `modalities` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `modality_levels` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `plans` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `allowedModalitiesNumber` on the `plans` table. All the data in the column will be lost.
  - The primary key for the `students` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `authUserid` on the `students` table. All the data in the column will be lost.
  - You are about to drop the column `documentNumber` on the `students` table. All the data in the column will be lost.
  - You are about to drop the column `modalityLevelId` on the `students` table. All the data in the column will be lost.
  - You are about to drop the column `planId` on the `students` table. All the data in the column will be lost.
  - The primary key for the `teachers` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `authUserid` on the `teachers` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[auth_user_id]` on the table `students` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[auth_user_id]` on the table `teachers` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `class_id` to the `appointments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `create_ad` to the `appointments` table without a default value. This is not possible if the table is not empty.
  - Added the required column `created_at` to the `authentication` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password_hash` to the `authentication` table without a default value. This is not possible if the table is not empty.
  - Added the required column `two_fa_key` to the `authentication` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updated_at` to the `authentication` table without a default value. This is not possible if the table is not empty.
  - Added the required column `club_unit_id` to the `classes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `maximum_students` to the `classes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `modality_id` to the `classes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `students_booked` to the `classes` table without a default value. This is not possible if the table is not empty.
  - Added the required column `latitude` to the `club_units` table without a default value. This is not possible if the table is not empty.
  - Added the required column `longitude` to the `club_units` table without a default value. This is not possible if the table is not empty.
  - Added the required column `allowed_modalities_number` to the `plans` table without a default value. This is not possible if the table is not empty.
  - Added the required column `auth_user_id` to the `students` table without a default value. This is not possible if the table is not empty.
  - Added the required column `document_number` to the `students` table without a default value. This is not possible if the table is not empty.
  - Added the required column `modality_level_id` to the `students` table without a default value. This is not possible if the table is not empty.
  - Added the required column `plan_id` to the `students` table without a default value. This is not possible if the table is not empty.
  - Added the required column `auth_user_id` to the `teachers` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "_ModalityToStudent" DROP CONSTRAINT "_ModalityToStudent_A_fkey";

-- DropForeignKey
ALTER TABLE "_ModalityToStudent" DROP CONSTRAINT "_ModalityToStudent_B_fkey";

-- DropForeignKey
ALTER TABLE "_ModalityToTeacher" DROP CONSTRAINT "_ModalityToTeacher_A_fkey";

-- DropForeignKey
ALTER TABLE "_ModalityToTeacher" DROP CONSTRAINT "_ModalityToTeacher_B_fkey";

-- DropForeignKey
ALTER TABLE "appointments" DROP CONSTRAINT "appointments_classId_fkey";

-- DropForeignKey
ALTER TABLE "appointments" DROP CONSTRAINT "appointments_studentId_fkey";

-- DropForeignKey
ALTER TABLE "classes" DROP CONSTRAINT "classes_clubUnitId_fkey";

-- DropForeignKey
ALTER TABLE "classes" DROP CONSTRAINT "classes_modalityId_fkey";

-- DropForeignKey
ALTER TABLE "classes" DROP CONSTRAINT "classes_teacherId_fkey";

-- DropForeignKey
ALTER TABLE "students" DROP CONSTRAINT "students_authUserid_fkey";

-- DropForeignKey
ALTER TABLE "students" DROP CONSTRAINT "students_modalityLevelId_fkey";

-- DropForeignKey
ALTER TABLE "students" DROP CONSTRAINT "students_planId_fkey";

-- DropForeignKey
ALTER TABLE "teachers" DROP CONSTRAINT "teachers_authUserid_fkey";

-- DropIndex
DROP INDEX "students_authUserid_key";

-- DropIndex
DROP INDEX "teachers_authUserid_key";

-- AlterTable
ALTER TABLE "_ModalityToStudent" ALTER COLUMN "A" SET DATA TYPE TEXT,
ALTER COLUMN "B" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "_ModalityToTeacher" ALTER COLUMN "A" SET DATA TYPE TEXT,
ALTER COLUMN "B" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "appointments" DROP CONSTRAINT "appointments_pkey",
DROP COLUMN "classId",
DROP COLUMN "createAd",
ADD COLUMN     "class_id" TEXT NOT NULL,
ADD COLUMN     "create_ad" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "studentId" SET DATA TYPE TEXT,
ADD CONSTRAINT "appointments_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "appointments_id_seq";

-- AlterTable
ALTER TABLE "authentication" DROP CONSTRAINT "authentication_pkey",
DROP COLUMN "createdAt",
DROP COLUMN "password",
DROP COLUMN "twoFaKey",
DROP COLUMN "updatedAt",
ADD COLUMN     "created_at" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "password_hash" TEXT NOT NULL,
ADD COLUMN     "two_fa_key" TEXT NOT NULL,
ADD COLUMN     "updated_at" TIMESTAMP(3) NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "authentication_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "authentication_id_seq";

-- AlterTable
ALTER TABLE "classes" DROP CONSTRAINT "classes_pkey",
DROP COLUMN "clubUnitId",
DROP COLUMN "maximumStudents",
DROP COLUMN "modalityId",
DROP COLUMN "studentsBooked",
ADD COLUMN     "club_unit_id" TEXT NOT NULL,
ADD COLUMN     "maximum_students" INTEGER NOT NULL,
ADD COLUMN     "modality_id" TEXT NOT NULL,
ADD COLUMN     "students_booked" INTEGER NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "teacherId" SET DATA TYPE TEXT,
ADD CONSTRAINT "classes_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "classes_id_seq";

-- AlterTable
ALTER TABLE "club_units" DROP CONSTRAINT "club_units_pkey",
ADD COLUMN     "latitude" DECIMAL(65,30) NOT NULL,
ADD COLUMN     "longitude" DECIMAL(65,30) NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "club_units_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "club_units_id_seq";

-- AlterTable
ALTER TABLE "modalities" DROP CONSTRAINT "modalities_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "modalities_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "modalities_id_seq";

-- AlterTable
ALTER TABLE "modality_levels" DROP CONSTRAINT "modality_levels_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "modality_levels_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "modality_levels_id_seq";

-- AlterTable
ALTER TABLE "plans" DROP CONSTRAINT "plans_pkey",
DROP COLUMN "allowedModalitiesNumber",
ADD COLUMN     "allowed_modalities_number" INTEGER NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "plans_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "plans_id_seq";

-- AlterTable
ALTER TABLE "students" DROP CONSTRAINT "students_pkey",
DROP COLUMN "authUserid",
DROP COLUMN "documentNumber",
DROP COLUMN "modalityLevelId",
DROP COLUMN "planId",
ADD COLUMN     "auth_user_id" TEXT NOT NULL,
ADD COLUMN     "document_number" TEXT NOT NULL,
ADD COLUMN     "modality_level_id" TEXT NOT NULL,
ADD COLUMN     "plan_id" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "students_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "students_id_seq";

-- AlterTable
ALTER TABLE "teachers" DROP CONSTRAINT "teachers_pkey",
DROP COLUMN "authUserid",
ADD COLUMN     "auth_user_id" TEXT NOT NULL,
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "teachers_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "teachers_id_seq";

-- CreateIndex
CREATE UNIQUE INDEX "students_auth_user_id_key" ON "students"("auth_user_id");

-- CreateIndex
CREATE UNIQUE INDEX "teachers_auth_user_id_key" ON "teachers"("auth_user_id");

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_modality_level_id_fkey" FOREIGN KEY ("modality_level_id") REFERENCES "modality_levels"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "plans"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "students" ADD CONSTRAINT "students_auth_user_id_fkey" FOREIGN KEY ("auth_user_id") REFERENCES "authentication"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "teachers" ADD CONSTRAINT "teachers_auth_user_id_fkey" FOREIGN KEY ("auth_user_id") REFERENCES "authentication"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes" ADD CONSTRAINT "classes_modality_id_fkey" FOREIGN KEY ("modality_id") REFERENCES "modalities"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes" ADD CONSTRAINT "classes_teacherId_fkey" FOREIGN KEY ("teacherId") REFERENCES "teachers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "classes" ADD CONSTRAINT "classes_club_unit_id_fkey" FOREIGN KEY ("club_unit_id") REFERENCES "club_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_studentId_fkey" FOREIGN KEY ("studentId") REFERENCES "students"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "appointments" ADD CONSTRAINT "appointments_class_id_fkey" FOREIGN KEY ("class_id") REFERENCES "classes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ModalityToStudent" ADD CONSTRAINT "_ModalityToStudent_A_fkey" FOREIGN KEY ("A") REFERENCES "modalities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ModalityToStudent" ADD CONSTRAINT "_ModalityToStudent_B_fkey" FOREIGN KEY ("B") REFERENCES "students"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ModalityToTeacher" ADD CONSTRAINT "_ModalityToTeacher_A_fkey" FOREIGN KEY ("A") REFERENCES "modalities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ModalityToTeacher" ADD CONSTRAINT "_ModalityToTeacher_B_fkey" FOREIGN KEY ("B") REFERENCES "teachers"("id") ON DELETE CASCADE ON UPDATE CASCADE;
