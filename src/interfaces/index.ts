export default interface RegisterUseCaseProps {
  name: string
  email: string
  password: string
  modality: string
}

export default interface RegisterRepositoriesProps {
  name: string
  email: string
  password: string
  role: 'STUDENT'
  student: {
    create: {
      modality: { connect: { id: string } }
      modality_level_id: string
      plan_id: string
      status: 'TRIAL'
    }
  }
}
