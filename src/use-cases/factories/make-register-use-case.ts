import { PrismaUserRepository } from "@/http/repositories/prisma/prisma-user-repository";
import { RegisterUseCase } from "../register";

export function makeRegisterUseCase() {
  const usersRepository = new PrismaUserRepository();
  const registerUseCase = new RegisterUseCase(usersRepository);
  return registerUseCase;
}
