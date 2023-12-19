import { $Enums, Prisma } from "@prisma/client";
import { prisma } from "@/lib/prisma";
import { UsersRepository } from "../users-repository";


export class PrismaUserRepository implements UsersRepository {
  async findById(id: string) {
    const user = await prisma.user.findUnique({
      where: { id }
    })

    return user

  }
  async findByEmail(email: string) {
    const user = await prisma.user.findUnique({
      where: { email }
    })

    return user

  }
  async create({
    name,
    email,
    password,
    role
  }: Prisma.UserCreateInput) {

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