import { Prisma } from "@prisma/client";
import RegisterRepositoriesProps from "../../interfaces";
import { prisma } from "../../lib/prisma";


type User = Prisma.UserCreateInput & {
  Usuario?: Prisma.UserCreateNestedManyWithoutStudentInput;
};

export class PrismaUserRepository {
  async create(data: User ) {
    const user = await prisma.user.create({
      data,
    })

    return user
  }
}