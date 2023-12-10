/*
  Warnings:

  - You are about to drop the column `adminId` on the `users` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_adminId_fkey";

-- AlterTable
ALTER TABLE "students" ALTER COLUMN "modality_level_id" SET DEFAULT '1894c606-29e4-4801-bd62-07eaf593a862',
ALTER COLUMN "plan_id" SET DEFAULT '0e8629e6-4bb6-4296-a4ef-7a63ae354fec',
ALTER COLUMN "status" SET DEFAULT 'TRIAL';

-- AlterTable
ALTER TABLE "users" DROP COLUMN "adminId";

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_admin_id_fkey" FOREIGN KEY ("admin_id") REFERENCES "admin_profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;
