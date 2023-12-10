import { Prisma } from "@prisma/client";
import { prisma } from "../../lib/prisma";


export class PrismaUserRepository {
  async create({
    name,
    email,
    password,
    role }: Prisma.UserCreateInput) {

    const user = await prisma.user.create({
      data: {
        name,
        email,
        password,
        role
      }
    })

    return user
  }
}