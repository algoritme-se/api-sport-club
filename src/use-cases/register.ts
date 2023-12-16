import { hash } from "bcryptjs"
import { prisma } from "@/lib/prisma"
import { Prisma } from "@prisma/client"
import { UsersRepository } from "@/http/repositories/users-repository"
import { UserAlreadyExistsError } from "./errors/user-already-exists"


export class RegisterUseCase {

  constructor(private usersRepository: UsersRepository) { }

  async execute({ name, email, password, role }: Prisma.UserCreateInput) {
    const password_hash = await hash(password, 6)

    const userWithSameEmail = await this.usersRepository.findByEmail(email)

    if (userWithSameEmail) {
      throw new UserAlreadyExistsError()
    }

    await this.usersRepository.create({
      name,
      email,
      password: password_hash,
      role
    }
    )
  }

}
