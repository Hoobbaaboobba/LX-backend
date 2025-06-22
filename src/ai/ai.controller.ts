import { Controller, Post, Body } from '@nestjs/common';
import { AiService } from './ai.service';
import { GenerateBranchDto } from './dto/generate-branch.dto';

@Controller('ai')
export class AiController {
  constructor(private readonly aiService: AiService) {}

  @Post('generate-branch')
  generateBranchName(@Body() dto: GenerateBranchDto) {
    return this.aiService.generateBranchName(dto.title);
  }
}
