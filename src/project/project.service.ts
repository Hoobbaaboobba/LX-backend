import { Injectable } from '@nestjs/common';
import { Task } from '@prisma/client';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class ProjectService {
  constructor(private prisma: PrismaService) {}

  async getAllProjects() {
    return this.prisma.project.findMany();
  }

  async getTasksByProjectId(projectId: string) {
    return this.prisma.task.findMany({
      where: {
        projectId: projectId,
      },
      include: {
        assignee: true,
        project: true,
      },
    });
  }

  async getTaskById(id: string) {
    return this.prisma.task.findUnique({
      where: {
        id: id,
      },
      include: {
        assignee: true,
        project: true,
      },
    });
  }

  async updateTask(task: Task) {
    return this.prisma.task.update({
      where: {
        id: task.id,
      },
      data: {
        title: task.title,
        dueDate: task.dueDate,
        assigneeId: task.assigneeId,
        priority: task.priority,
        description: task.description,
        status: task.status,
      },
    });
  }

  async createTask(task: Task) {
    return this.prisma.task.create({
      data: {
        title: task.title,
        description: task.description,
        status: task.status,
        progress: task.progress,
        dueDate: task.dueDate,
        priority: task.priority,
        projectId: task.projectId,
        assigneeId: task.assigneeId,
      },
    });
  }
}
