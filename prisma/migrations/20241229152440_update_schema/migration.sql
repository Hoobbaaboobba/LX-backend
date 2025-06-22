-- DropForeignKey
ALTER TABLE "designs" DROP CONSTRAINT "designs_userId_fkey";

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

-- AddForeignKey
ALTER TABLE "designs" ADD CONSTRAINT "designs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "layers" ADD CONSTRAINT "layers_designId_fkey" FOREIGN KEY ("designId") REFERENCES "designs"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "layer_breakpoints" ADD CONSTRAINT "layer_breakpoints_layerId_fkey" FOREIGN KEY ("layerId") REFERENCES "layers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "layouts" ADD CONSTRAINT "layouts_layerId_fkey" FOREIGN KEY ("layerId") REFERENCES "layers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "sections" ADD CONSTRAINT "sections_layerId_fkey" FOREIGN KEY ("layerId") REFERENCES "layers"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "folders" ADD CONSTRAINT "folders_sectionId_fkey" FOREIGN KEY ("sectionId") REFERENCES "sections"("id") ON DELETE CASCADE ON UPDATE CASCADE;
