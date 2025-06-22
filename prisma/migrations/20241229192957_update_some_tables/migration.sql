/*
  Warnings:

  - You are about to drop the column `folderId` on the `files` table. All the data in the column will be lost.
  - You are about to drop the `folders` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `designId` to the `files` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "files" DROP CONSTRAINT "files_folderId_fkey";

-- DropForeignKey
ALTER TABLE "folders" DROP CONSTRAINT "folders_designId_fkey";

-- DropForeignKey
ALTER TABLE "folders" DROP CONSTRAINT "folders_parentId_fkey";

-- AlterTable
ALTER TABLE "files" DROP COLUMN "folderId",
ADD COLUMN     "designId" TEXT NOT NULL,
ADD COLUMN     "parentId" TEXT;

-- DropTable
DROP TABLE "folders";

-- AddForeignKey
ALTER TABLE "files" ADD CONSTRAINT "files_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "files"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "files" ADD CONSTRAINT "files_designId_fkey" FOREIGN KEY ("designId") REFERENCES "designs"("id") ON DELETE CASCADE ON UPDATE CASCADE;
