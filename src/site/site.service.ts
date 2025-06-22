import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { CreateSiteDto } from './dto/create-site.dto';

@Injectable()
export class SiteService {
  constructor(private prisma: PrismaService) {}

  async getSite(id: string) {
    return this.prisma.site.findMany({
      where: {
        teamId: id,
      },
    });
  }

  async createSite(site: CreateSiteDto) {
    return this.prisma.site.create({
      data: {
        name: site.name,
        teamId: site.teamId,
      },
    });
  }
}
