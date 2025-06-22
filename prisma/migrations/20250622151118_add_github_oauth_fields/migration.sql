/*
  Warnings:

  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `designs` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `files` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('LEXUS', 'ADMIN', 'MEMBER');

-- CreateEnum
CREATE TYPE "Priority" AS ENUM ('LOW', 'MEDIUM', 'HIGH');

-- CreateEnum
CREATE TYPE "TaskStatus" AS ENUM ('TODO', 'IN_PROGRESS', 'DONE');

-- CreateEnum
CREATE TYPE "TeamMemberRole" AS ENUM ('ADMIN', 'MEMBER');

-- DropForeignKey
ALTER TABLE "designs" DROP CONSTRAINT "designs_userId_fkey";

-- DropForeignKey
ALTER TABLE "files" DROP CONSTRAINT "files_designId_fkey";

-- DropForeignKey
ALTER TABLE "files" DROP CONSTRAINT "files_parentId_fkey";

-- DropTable
DROP TABLE "User";

-- DropTable
DROP TABLE "designs";

-- DropTable
DROP TABLE "files";

-- DropEnum
DROP TYPE "FileType";

-- DropEnum
DROP TYPE "Position";

-- DropEnum
DROP TYPE "Subscription";

-- DropEnum
DROP TYPE "TextAlign";

-- DropEnum
DROP TYPE "TextHeight";

-- DropEnum
DROP TYPE "TextPositions";

-- DropEnum
DROP TYPE "TextWeight";

-- DropEnum
DROP TYPE "TextWidth";

-- CreateTable
CREATE TABLE "users" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT,
    "githubId" TEXT,
    "githubAvatar" TEXT,
    "role" "UserRole" NOT NULL DEFAULT 'MEMBER',

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "projects" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "title" TEXT NOT NULL,
    "progress" INTEGER NOT NULL DEFAULT 0,
    "dueDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "projects_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tasks" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "priority" "Priority" NOT NULL,
    "status" "TaskStatus" NOT NULL DEFAULT 'TODO',
    "projectId" TEXT NOT NULL,
    "dueDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "progress" INTEGER NOT NULL DEFAULT 0,
    "assigneeId" TEXT,

    CONSTRAINT "tasks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "teams" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "teams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "team_members" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "role" "TeamMemberRole" NOT NULL DEFAULT 'MEMBER',

    CONSTRAINT "team_members_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "team_invites" (
    "id" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "token" TEXT,
    "role" "TeamMemberRole" NOT NULL DEFAULT 'MEMBER',
    "expiresAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "team_invites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sites" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "domain" TEXT NOT NULL,
    "teamId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "sites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_UserProjects" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "users_githubId_key" ON "users"("githubId");

-- CreateIndex
CREATE UNIQUE INDEX "team_members_userId_teamId_key" ON "team_members"("userId", "teamId");

-- CreateIndex
CREATE UNIQUE INDEX "team_invites_token_key" ON "team_invites"("token");

-- CreateIndex
CREATE UNIQUE INDEX "_UserProjects_AB_unique" ON "_UserProjects"("A", "B");

-- CreateIndex
CREATE INDEX "_UserProjects_B_index" ON "_UserProjects"("B");

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "projects"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_assigneeId_fkey" FOREIGN KEY ("assigneeId") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "team_members" ADD CONSTRAINT "team_members_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "team_members" ADD CONSTRAINT "team_members_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "team_invites" ADD CONSTRAINT "team_invites_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sites" ADD CONSTRAINT "sites_teamId_fkey" FOREIGN KEY ("teamId") REFERENCES "teams"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserProjects" ADD CONSTRAINT "_UserProjects_A_fkey" FOREIGN KEY ("A") REFERENCES "projects"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_UserProjects" ADD CONSTRAINT "_UserProjects_B_fkey" FOREIGN KEY ("B") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
