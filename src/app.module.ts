import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { ConfigModule } from '@nestjs/config';
import { SiteModule } from './site/site.module';
import { TeamModule } from './team/team.module';
import { ProjectModule } from './project/project.module';
import { AiModule } from './ai/ai.module';

@Module({
  imports: [
    ConfigModule.forRoot(),
    AuthModule,
    UserModule,
    SiteModule,
    TeamModule,
    ProjectModule,
    AiModule,
  ],
})
export class AppModule {}
