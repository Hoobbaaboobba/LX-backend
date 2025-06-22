/*
  Warnings:

  - You are about to drop the column `sectionId` on the `files` table. All the data in the column will be lost.
  - You are about to drop the column `sectionId` on the `folders` table. All the data in the column will be lost.
  - You are about to drop the `layers` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `layouts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sections` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "files" DROP CONSTRAINT "files_sectionId_fkey";

-- DropForeignKey
ALTER TABLE "folders" DROP CONSTRAINT "folders_sectionId_fkey";

-- DropForeignKey
ALTER TABLE "layer_breakpoints" DROP CONSTRAINT "layer_breakpoints_layerId_fkey";

-- DropForeignKey
ALTER TABLE "layers" DROP CONSTRAINT "layers_designId_fkey";

-- DropForeignKey
ALTER TABLE "layouts" DROP CONSTRAINT "layouts_layerId_fkey";

-- DropForeignKey
ALTER TABLE "sections" DROP CONSTRAINT "sections_layerId_fkey";

-- AlterTable
ALTER TABLE "files" DROP COLUMN "sectionId";

-- AlterTable
ALTER TABLE "folders" DROP COLUMN "sectionId";

-- DropTable
DROP TABLE "layers";

-- DropTable
DROP TABLE "layouts";

-- DropTable
DROP TABLE "sections";
