/*
  Warnings:

  - Added the required column `rightAnswer` to the `modules` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "User" ALTER COLUMN "subscription" SET DEFAULT 'FREE';

-- AlterTable
ALTER TABLE "modules" ADD COLUMN     "rightAnswer" BOOLEAN NOT NULL;
