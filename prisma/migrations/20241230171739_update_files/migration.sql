-- CreateEnum
CREATE TYPE "TextPositions" AS ENUM ('Absolute', 'Relative', 'Fixed', 'Sticky');

-- CreateEnum
CREATE TYPE "TextWidth" AS ENUM ('Fixed', 'Relative', 'Fill', 'FitContent');

-- CreateEnum
CREATE TYPE "TextHeight" AS ENUM ('Fixed', 'Relative', 'Fill', 'FitContent', 'Viewport');

-- CreateEnum
CREATE TYPE "TextWeight" AS ENUM ('Light', 'Regular', 'Medium', 'SemiBold', 'Bold');

-- CreateEnum
CREATE TYPE "TextAlign" AS ENUM ('Left', 'Center', 'Right');

-- AlterTable
ALTER TABLE "files" ALTER COLUMN "type" DROP NOT NULL;

-- CreateTable
CREATE TABLE "text_styles" (
    "id" TEXT NOT NULL,
    "fileId" TEXT NOT NULL,
    "position" "TextPositions" NOT NULL DEFAULT 'Relative',
    "width1" TEXT NOT NULL DEFAULT 'auto',
    "width2" "TextWidth" NOT NULL DEFAULT 'Fixed',
    "height1" TEXT NOT NULL DEFAULT 'auto',
    "height2" "TextWidth" NOT NULL DEFAULT 'Fixed',
    "content" TEXT NOT NULL DEFAULT 'Gey started',
    "font" TEXT NOT NULL DEFAULT 'Roboto',
    "weight" "TextWeight" NOT NULL DEFAULT 'Regular',
    "color" TEXT NOT NULL DEFAULT '#000000',
    "size" INTEGER NOT NULL DEFAULT 16,
    "align" "TextAlign" NOT NULL DEFAULT 'Left',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "text_styles_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "text_styles_fileId_key" ON "text_styles"("fileId");

-- AddForeignKey
ALTER TABLE "text_styles" ADD CONSTRAINT "text_styles_fileId_fkey" FOREIGN KEY ("fileId") REFERENCES "files"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
