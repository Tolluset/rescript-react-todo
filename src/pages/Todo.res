@module external styles: {..} = "./Todo.module.css"

type todo = {
  id: int,
  title: string,
  completed: bool,
}

external typeTodos: Js.Json.t => array<todo> = "%identity"

@react.component
let make = () => {
  let (todos, setTodos) = React.useState(_ => [])

  React.useEffect1(() => {
    (
      async () => {
        let url = "https://jsonplaceholder.typicode.com/users/1/todos"

        let todosJson = await Fetch.fetch(url)->Promise.then(Fetch.Response.json)

        let todos = typeTodos(todosJson)

        setTodos(prev => prev->Js.Array2.concat(todos))
      }
    )()->ignore
  }, [])

  <div>
    {todos
    ->Belt.Array.map(todo =>
      <div key={Belt.Int.toString(todo.id)}>
        <span style={ReactDOM.Style.make(~marginRight="10px", ())}>
          {switch todo.completed {
          | true => "✅"->React.string
          | false => "❎"->React.string
          }}
        </span>
        <span> {todo.title->React.string} </span>
      </div>
    )
    ->React.array}
  </div>
}
