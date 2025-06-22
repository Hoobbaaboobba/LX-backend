/*
  Warnings:

  - The values [TwoCol,ThreeCol] on the enum `FileType` will be removed. If these variants are still used in the database, this will fail.

*/
-- AlterEnum
BEGIN;
CREATE TYPE "FileType_new" AS ENUM ('text', 'container', 'section', 'contactForm', 'paymentForm', 'link', 'twoCol', 'video', 'body', 'image', 'null', 'threeCol');
ALTER TABLE "files" ALTER COLUMN "type" DROP DEFAULT;
ALTER TABLE "files" ALTER COLUMN "type" TYPE "FileType_new" USING ("type"::text::"FileType_new");
ALTER TYPE "FileType" RENAME TO "FileType_old";
ALTER TYPE "FileType_new" RENAME TO "FileType";
DROP TYPE "FileType_old";
ALTER TABLE "files" ALTER COLUMN "type" SET DEFAULT 'null';
COMMIT;
