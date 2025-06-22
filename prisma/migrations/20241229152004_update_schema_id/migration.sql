/*
  Warnings:

  - The primary key for the `designs` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `files` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `folders` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `layer_breakpoints` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `layers` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `layouts` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - The primary key for the `sections` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- DropForeignKey
ALTER TABLE "files" DROP CONSTRAINT "files_folderId_fkey";

-- DropForeignKey
ALTER TABLE "files" DROP CONSTRAINT "files_sectionId_fkey";

-- DropForeignKey
ALTER TABLE "folders" DROP CONSTRAINT "folders_parentId_fkey";

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
ALTER TABLE "designs" DROP CONSTRAINT "designs_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ADD CONSTRAINT "designs_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "designs_id_seq";

-- AlterTable
ALTER TABLE "files" DROP CONSTRAINT "files_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "sectionId" SET DATA TYPE TEXT,
ALTER COLUMN "folderId" SET DATA TYPE TEXT,
ADD CONSTRAINT "files_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "files_id_seq";

-- AlterTable
ALTER TABLE "folders" DROP CONSTRAINT "folders_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "parentId" SET DATA TYPE TEXT,
ALTER COLUMN "sectionId" SET DATA TYPE TEXT,
ADD CONSTRAINT "folders_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "folders_id_seq";

-- AlterTable
ALTER TABLE "layer_breakpoints" DROP CONSTRAINT "layer_breakpoints_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "layerId" SET DATA TYPE TEXT,
ADD CONSTRAINT "layer_breakpoints_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "layer_breakpoints_id_seq";

-- AlterTable
ALTER TABLE "layers" DROP CONSTRAINT "layers_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "designId" SET DATA TYPE TEXT,
ADD CONSTRAINT "layers_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "layers_id_seq";

-- AlterTable
ALTER TABLE "layouts" DROP CONSTRAINT "layouts_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "layerId" SET DATA TYPE TEXT,
ADD CONSTRAINT "layouts_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "layouts_id_seq";

-- AlterTable
ALTER TABLE "sections" DROP CONSTRAINT "sections_pkey",
ALTER COLUMN "id" DROP DEFAULT,
ALTER COLUMN "id" SET DATA TYPE TEXT,
ALTER COLUMN "layerId" SET DATA TYPE TEXT,
ADD CONSTRAINT "sections_pkey" PRIMARY KEY ("id");
DROP SEQUENCE "sections_id_seq";

-- AddForeignKey
ALTER TABLE "layers" ADD CONSTRAINT "layers_designId_fkey" FOREIGN KEY ("designId") REFERENCES "designs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "layer_breakpoints" ADD CONSTRAINT "layer_breakpoints_layerId_fkey" FOREIGN KEY ("layerId") REFERENCES "layers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "layouts" ADD CONSTRAINT "layouts_layerId_fkey" FOREIGN KEY ("layerId") REFERENCES "layers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sections" ADD CONSTRAINT "sections_layerId_fkey" FOREIGN KEY ("layerId") REFERENCES "layers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "folders" ADD CONSTRAINT "folders_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "folders"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "folders" ADD CONSTRAINT "folders_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "sections"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "files" ADD CONSTRAINT "files_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "sections"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "files" ADD CONSTRAINT "files_folderId_fkey" FOREIGN KEY ("folderId") REFERENCES "folders"("id") ON DELETE SET NULL ON UPDATE CASCADE;
