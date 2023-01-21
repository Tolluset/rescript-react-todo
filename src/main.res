// Use getExn to get error when can't find root tag
// ReactDOM.querySelector("#root1")
// ->Belt.Option.getExn
// ->ReactDOM.Client.createRoot
// ->ReactDOM.Client.Root.render(
//   <React.StrictMode>
//     <App />
//   </React.StrictMode>,
// )

let root = ReactDOM.querySelector("#root")

switch root {
| Some(root) =>
  root
  ->ReactDOM.Client.createRoot
  ->ReactDOM.Client.Root.render(
    <React.StrictMode>
      <App />
    </React.StrictMode>,
  )
| None => Js.Exn.raiseError("Not found root tag")
}
