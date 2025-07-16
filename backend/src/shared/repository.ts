export interface Repository<T> {
  findAll(): Promise<T[]>;
  findOne(id: string): Promise<T | undefined>;
  add(item: T): Promise<T | undefined>;
  update(id: string, item: Partial<T>): Promise<T | undefined>;
  delete(id: string): Promise<T | undefined>;
}