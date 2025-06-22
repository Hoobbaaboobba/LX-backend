import { Module } from '@nestjs/common';
import { SiteService } from './site.service';
import { SiteController } from './site.controller';
import { PrismaService } from 'src/prisma.service';

@Module({
  controllers: [SiteController],
  providers: [SiteService, PrismaService],
  exports: [SiteService],
})
export class SiteModule {}
