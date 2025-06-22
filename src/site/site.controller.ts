import { Body, Controller, HttpCode, Post } from '@nestjs/common';
import { SiteService } from './site.service';
import { CurrentUser } from 'src/auth/decorators/user.decorator';
import { Auth } from 'src/auth/decorators/auth.decorator';
import { CreateSiteDto } from './dto/create-site.dto';

@Controller('site')
export class SiteController {
  constructor(private readonly siteService: SiteService) {}

  @HttpCode(200)
  @Post()
  @Auth()
  create(@CurrentUser('id') id: string) {
    return this.siteService.getSite(id);
  }

  @HttpCode(200)
  @Post('create')
  @Auth()
  createDesign(@Body() site: CreateSiteDto) {
    return this.siteService.createSite(site);
  }
}
