/*
  Warnings:

  - You are about to drop the column `rightAnswer` on the `modules` table. All the data in the column will be lost.
  - You are about to drop the `_UserCourses` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "UserCourseProgressStatus" AS ENUM ('NOT_STARTED', 'IN_PROGRESS', 'COMPLETED');

-- DropForeignKey
ALTER TABLE "_UserCourses" DROP CONSTRAINT "_UserCourses_A_fkey";

-- DropForeignKey
ALTER TABLE "_UserCourses" DROP CONSTRAINT "_UserCourses_B_fkey";

-- AlterTable
ALTER TABLE "modules" DROP COLUMN "rightAnswer";

-- DropTable
DROP TABLE "_UserCourses";

-- CreateTable
CREATE TABLE "user_course_progress" (
    "id" SERIAL NOT NULL,
    "userId" TEXT NOT NULL,
    "courseId" INTEGER NOT NULL,
    "status" "UserCourseProgressStatus" NOT NULL DEFAULT 'NOT_STARTED',
    "progress" DOUBLE PRECISION NOT NULL DEFAULT 0.0,
    "startedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "score" DOUBLE PRECISION,

    CONSTRAINT "user_course_progress_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_course_progress_userId_courseId_key" ON "user_course_progress"("userId", "courseId");

-- AddForeignKey
ALTER TABLE "user_course_progress" ADD CONSTRAINT "user_course_progress_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_course_progress" ADD CONSTRAINT "user_course_progress_courseId_fkey" FOREIGN KEY ("courseId") REFERENCES "courses"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
