export function substitute(collection: Array<Array<string>>, item: string) {
  return collection.find(([from]) => from === item)?.[1] || item;
}
