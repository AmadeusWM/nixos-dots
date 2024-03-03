// export const capsLock = Variable(false, {
//   poll: [
//     100,
//     ["bash", "-c", `brightnessctl --device="input*::capslock" get`],
//     (out) => {
//       let capsOn = out === "1";
//       return capsOn
//     },
//   ],
// });

export const capsLock = Variable(false)
globalThis.capsLock = capsLock