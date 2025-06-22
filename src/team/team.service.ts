import { Injectable } from '@nestjs/common';
import { CreateTeamDto } from './dto/create-team.dto';
import { UpdateTeamDto } from './dto/update-team.dto';
import { InviteTeamDto } from './dto/invite-team.dto';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class TeamService {
  constructor(private prisma: PrismaService) {}

  async acceptInvitation(inviteTeam: InviteTeamDto) {
    const invitation = await this.prisma.teamInvite.findUnique({
      where: {
        token: inviteTeam.token,
      },
    });
    return this.prisma.teamMember.create({
      data: {
        userId: inviteTeam.userId,
        teamId: inviteTeam.teamId,
      },
    });
  }

  findAll() {
    return `This action returns all team`;
  }

  findOne(id: number) {
    return `This action returns a #${id} team`;
  }

  update(id: number, updateTeamDto: UpdateTeamDto) {
    return `This action updates a #${id} team`;
  }

  remove(id: number) {
    return `This action removes a #${id} team`;
  }
}
