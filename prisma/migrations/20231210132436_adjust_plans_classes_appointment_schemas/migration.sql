/*
  Warnings:

  - You are about to drop the column `user_id` on the `appointments` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `classes` table. All the data in the column will be lost.
  - You are about to drop the column `user_id` on the `plans` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "appointments" DROP CONSTRAINT "appointments_user_id_fkey";

-- DropForeignKey
ALTER TABLE "classes" DROP CONSTRAINT "classes_user_id_fkey";

-- DropForeignKey
ALTER TABLE "plans" DROP CONSTRAINT "plans_user_id_fkey";

-- AlterTable
ALTER TABLE "appointments" DROP COLUMN "user_id";

-- AlterTable
ALTER TABLE "classes" DROP COLUMN "user_id";

-- AlterTable
ALTER TABLE "plans" DROP COLUMN "user_id";

-- CreateTable
CREATE TABLE "_ClassToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_AppointmentToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ClassToUser_AB_unique" ON "_ClassToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_ClassToUser_B_index" ON "_ClassToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AppointmentToUser_AB_unique" ON "_AppointmentToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_AppointmentToUser_B_index" ON "_AppointmentToUser"("B");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_plan_id_fkey" FOREIGN KEY ("plan_id") REFERENCES "plans"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClassToUser" ADD CONSTRAINT "_ClassToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "classes"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ClassToUser" ADD CONSTRAINT "_ClassToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AppointmentToUser" ADD CONSTRAINT "_AppointmentToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "appointments"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AppointmentToUser" ADD CONSTRAINT "_AppointmentToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
