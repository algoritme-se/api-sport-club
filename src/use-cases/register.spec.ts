import { expect, describe, it, beforeEach } from 'vitest'
import { RegisterUseCase } from './register';
import { compare } from 'bcryptjs';
import { InMemoryUserRepository } from '@/http/repositories/in-memory-database/in-memory-user-repository';
import { UserAlreadyExistsError } from './errors/user-already-exists';

let usersRepository: InMemoryUserRepository
let sut: RegisterUseCase

describe('User Register', () => {

  // execute before each test
  beforeEach(() => {
    usersRepository = new InMemoryUserRepository()
    sut = new RegisterUseCase(usersRepository)
  })

  it('should be hashed the password in the database', async () => {

    const { user } = await sut.execute({
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: '123456',
      role: 'STUDENT'
    })

    const isPasswordHashed = await compare('123456', user.password)

    expect(isPasswordHashed).toBe(true)
  })

  it('should not allow users to register with the same email address', async () => {

    await sut.execute({
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: '123456',
      role: 'STUDENT'
    })

    expect(async () => {
      const response = await sut.execute({
        name: 'Daniel Silva',
        email: 'danielsilva@example.com',
        password: '123456',
        role: 'STUDENT'
      })

      return response
    }).rejects.toBeInstanceOf(UserAlreadyExistsError)
  })

  it('user must register and have use_status equal to TRIAL', async () => {

    const { user } = await sut.execute({
      name: 'Daniel Silva',
      email: 'danielsilva@example.com',
      password: '123456',
      role: 'STUDENT'
    })

    expect(user.user_status).toBe('TRIAL')
  })
})