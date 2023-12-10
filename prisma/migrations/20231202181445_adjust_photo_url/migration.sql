/*
  Warnings:

  - You are about to drop the column `address` on the `students` table. All the data in the column will be lost.
  - You are about to drop the column `address` on the `users` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "students" DROP COLUMN "address",
ALTER COLUMN "photo_url" DROP NOT NULL;

-- AlterTable
ALTER TABLE "users" DROP COLUMN "address";
