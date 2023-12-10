import { hash } from "bcryptjs"
import { prisma } from "../lib/prisma"
import { PrismaUserRepository } from "../http/repositories/prisma-user-repository"
import RegisterUseCaseProps from "../interfaces"



export async function registerUseCase({
  name, email, password, modality
}: RegisterUseCaseProps) {
  const password_hash = await hash(password, 6)

  const userWithSameEmail = await prisma.user.findUnique({
    where: { email }
  })

  if (userWithSameEmail) {
    throw new Error('User already exists')
  }

  const prismaUserRepository = new PrismaUserRepository()

  await prismaUserRepository.create({
    name,
    email,
    password: password_hash,
    student: {
      create: {
        modality: { connect: { id: modality } },
      }
    }
  }
  )
}