import { Prisma, User } from "@prisma/client";
import { UsersRepository } from "../users-repository";
import { randomUUID } from "crypto";


export class InMemoryUserRepository implements UsersRepository {
  public items: User[] = []

  async findById(id: string) {
    const user = this.items.find(user => user.id === id)

    if (!user) {
      return null
    }
    return user

  }

  async findByEmail(email: string) {
    const user = this.items.find(user => user.email === email)

    if (!user) {
      return null
    }
    return user

  }
  async create(data: Prisma.UserCreateInput) {

    const user: User = {
      id: randomUUID(),
      name: data.name,
      photo_url: '',
      email: data.email,
      password: data.password,
      role: 'STUDENT',
      modality_level_id: null,
      user_status: 'TRIAL',
      plan_id: null
    }

    this.items.push(user)

    return user
  }
}