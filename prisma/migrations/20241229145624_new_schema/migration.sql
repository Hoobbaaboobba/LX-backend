/*
  Warnings:

  - You are about to drop the `Design` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Design" DROP CONSTRAINT "Design_userId_fkey";

-- DropForeignKey
ALTER TABLE "layers" DROP CONSTRAINT "layers_designId_fkey";

-- DropTable
DROP TABLE "Design";

-- CreateTable
CREATE TABLE "designs" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "designs_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "designs" ADD CONSTRAINT "designs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "layers" ADD CONSTRAINT "layers_designId_fkey" FOREIGN KEY ("designId") REFERENCES "designs"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
