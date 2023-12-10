/*
  Warnings:

  - You are about to drop the column `user_id` on the `modalities` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "modalities" DROP CONSTRAINT "modalities_user_id_fkey";

-- AlterTable
ALTER TABLE "modalities" DROP COLUMN "user_id";

-- CreateTable
CREATE TABLE "_ModalityToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ModalityToUser_AB_unique" ON "_ModalityToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_ModalityToUser_B_index" ON "_ModalityToUser"("B");

-- AddForeignKey
ALTER TABLE "_ModalityToUser" ADD CONSTRAINT "_ModalityToUser_A_fkey" FOREIGN KEY ("A") REFERENCES "modalities"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ModalityToUser" ADD CONSTRAINT "_ModalityToUser_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
