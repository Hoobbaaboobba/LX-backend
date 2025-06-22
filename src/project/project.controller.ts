import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Put,
  UsePipes,
  HttpCode,
  ValidationPipe,
} from '@nestjs/common';
import { ProjectService } from './project.service';
import { Auth } from 'src/auth/decorators/auth.decorator';
import { Task } from '@prisma/client';

@Controller('project')
export class ProjectController {
  constructor(private readonly projectService: ProjectService) {}

  @Get()
  @Auth()
  getAllProjects() {
    return this.projectService.getAllProjects();
  }

  @Get('tasks/:id')
  @Auth()
  getTasksByProjectId(@Param('id') id: string) {
    return this.projectService.getTasksByProjectId(id);
  }

  @Get('task/:id')
  @Auth()
  getTaskById(@Param('id') id: string) {
    return this.projectService.getTaskById(id);
  }

  @Put('tasks')
  @Auth()
  updateTask(@Body() dto: Task) {
    return this.projectService.updateTask(dto);
  }

  @Post('tasks')
  @Auth()
  createTask(@Body() dto: Task) {
    return this.projectService.createTask(dto);
  }
}
