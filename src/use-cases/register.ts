import { hash } from "bcryptjs"
import { Prisma, User } from "@prisma/client"
import { UsersRepository } from "@/http/repositories/users-repository"
import { UserAlreadyExistsError } from "./errors/user-already-exists"


interface RegisterUseCaseResponse {
  user: User
}
export class RegisterUseCase {

  constructor(private usersRepository: UsersRepository) { }

  async execute({ name, email, password, role }: Prisma.UserCreateInput): Promise<RegisterUseCaseResponse> {
    const password_hash = await hash(password, 6)

    const userWithSameEmail = await this.usersRepository.findByEmail(email)

    if (userWithSameEmail) {
      throw new UserAlreadyExistsError()
    }

    const user = await this.usersRepository.create({
      name,
      email,
      password: password_hash,
      role
    }
    )

    return {
      user
    }
  }

}
