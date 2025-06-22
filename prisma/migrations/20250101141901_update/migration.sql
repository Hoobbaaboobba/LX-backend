/*
  Warnings:

  - The `type` column on the `files` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `layer_breakpoints` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "FileType" AS ENUM ('text', 'container', 'section', 'contactForm', 'paymentForm', 'link', 'TwoCol', 'video', 'body', 'image', 'null', 'ThreeCol');

-- AlterTable
ALTER TABLE "files" DROP COLUMN "type",
ADD COLUMN     "type" "FileType" NOT NULL DEFAULT 'null';

-- DropTable
DROP TABLE "layer_breakpoints";
