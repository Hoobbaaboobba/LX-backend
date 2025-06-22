/*
  Warnings:

  - Added the required column `designId` to the `folders` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "files" DROP CONSTRAINT "files_folderId_fkey";

-- DropForeignKey
ALTER TABLE "folders" DROP CONSTRAINT "folders_parentId_fkey";

-- AlterTable
ALTER TABLE "folders" ADD COLUMN     "designId" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "folders" ADD CONSTRAINT "folders_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "folders"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "folders" ADD CONSTRAINT "folders_designId_fkey" FOREIGN KEY ("designId") REFERENCES "designs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "files" ADD CONSTRAINT "files_folderId_fkey" FOREIGN KEY ("folderId") REFERENCES "folders"("id") ON DELETE CASCADE ON UPDATE CASCADE;
