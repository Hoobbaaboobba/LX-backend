/*
  Warnings:

  - You are about to drop the `text_styles` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "text_styles" DROP CONSTRAINT "text_styles_fileId_fkey";

-- AlterTable
ALTER TABLE "files" ADD COLUMN     "styles" JSONB;

-- DropTable
DROP TABLE "text_styles";
