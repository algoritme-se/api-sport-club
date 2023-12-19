import { PrismaUserRepository } from "@/http/repositories/prisma/prisma-user-repository";
import { GetUserProfileUseCase } from "../get-user-profile";

export function makeGetUserProfileCase() {
  const usersRepository = new PrismaUserRepository();
  const getUserProfileUseCase = new GetUserProfileUseCase(usersRepository);
  return getUserProfileUseCase;
}
