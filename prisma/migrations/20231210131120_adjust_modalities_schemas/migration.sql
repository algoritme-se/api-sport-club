/*
  Warnings:

  - You are about to drop the column `user_id` on the `modality_levels` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "modality_levels" DROP CONSTRAINT "modality_levels_user_id_fkey";

-- AlterTable
ALTER TABLE "modality_levels" DROP COLUMN "user_id";

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_modality_level_id_fkey" FOREIGN KEY ("modality_level_id") REFERENCES "modality_levels"("id") ON DELETE SET NULL ON UPDATE CASCADE;
