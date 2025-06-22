/*
  Warnings:

  - You are about to drop the `courses` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `modules` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user_course_progress` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "Position" AS ENUM ('Fixed', 'Relative', 'Fill', 'FitContent', 'Fit', 'Viewport');

-- CreateEnum
CREATE TYPE "LayerType" AS ENUM ('Stack', 'Grid');

-- CreateEnum
CREATE TYPE "StackDirection" AS ENUM ('Horizontal', 'Vertical');

-- CreateEnum
CREATE TYPE "StackDistribution" AS ENUM ('Start', 'Center', 'End', 'SpaceBetween', 'SpaceAround', 'SpaceEvenly');

-- CreateEnum
CREATE TYPE "Alignment" AS ENUM ('Start', 'Center', 'End');

-- CreateEnum
CREATE TYPE "Wrap" AS ENUM ('Yes', 'No');

-- CreateEnum
CREATE TYPE "Cursor" AS ENUM ('Default', 'Grab', 'Grabbing');

-- DropForeignKey
ALTER TABLE "modules" DROP CONSTRAINT "modules_courseId_fkey";

-- DropForeignKey
ALTER TABLE "user_course_progress" DROP CONSTRAINT "user_course_progress_courseId_fkey";

-- DropForeignKey
ALTER TABLE "user_course_progress" DROP CONSTRAINT "user_course_progress_userId_fkey";

-- DropTable
DROP TABLE "courses";

-- DropTable
DROP TABLE "modules";

-- DropTable
DROP TABLE "user_course_progress";

-- DropEnum
DROP TYPE "UserCourseProgressStatus";

-- CreateTable
CREATE TABLE "Design" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Design_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "layers" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "designId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "layers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "layer_breakpoints" (
    "id" SERIAL NOT NULL,
    "layerId" INTEGER NOT NULL,
    "x" INTEGER NOT NULL DEFAULT 0,
    "y" INTEGER NOT NULL DEFAULT 0,
    "width1" INTEGER NOT NULL DEFAULT 0,
    "width2" "Position" NOT NULL DEFAULT 'Fixed',
    "height1" INTEGER NOT NULL DEFAULT 0,
    "height2" "Position" NOT NULL DEFAULT 'Fit',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "layer_breakpoints_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "layouts" (
    "id" SERIAL NOT NULL,
    "layerId" INTEGER NOT NULL,
    "type" "LayerType" NOT NULL DEFAULT 'Stack',
    "direction" "StackDirection" NOT NULL DEFAULT 'Vertical',
    "distribution" "StackDistribution" NOT NULL DEFAULT 'Start',
    "alignment" "Alignment" NOT NULL DEFAULT 'Center',
    "wrap" "Wrap" NOT NULL DEFAULT 'No',
    "gap" INTEGER NOT NULL DEFAULT 0,
    "padding" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "layouts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sections" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "layerId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "folders" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "parentId" INTEGER,
    "sectionId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "folders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "files" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "sectionId" INTEGER,
    "folderId" INTEGER,
    "fileType" TEXT NOT NULL,
    "size" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "files_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Design" ADD CONSTRAINT "Design_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "layers" ADD CONSTRAINT "layers_designId_fkey" FOREIGN KEY ("designId") REFERENCES "Design"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

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
