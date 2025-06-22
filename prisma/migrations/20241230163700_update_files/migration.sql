/*
  Warnings:

  - You are about to drop the column `fileType` on the `files` table. All the data in the column will be lost.
  - You are about to drop the column `size` on the `files` table. All the data in the column will be lost.
  - Added the required column `type` to the `files` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "files" DROP COLUMN "fileType",
DROP COLUMN "size",
ADD COLUMN     "type" TEXT NOT NULL;

-- DropEnum
DROP TYPE "Alignment";

-- DropEnum
DROP TYPE "Cursor";

-- DropEnum
DROP TYPE "LayerType";

-- DropEnum
DROP TYPE "StackDirection";

-- DropEnum
DROP TYPE "StackDistribution";

-- DropEnum
DROP TYPE "Wrap";
