# ddts

A style guide for writing better typescript, enforced via eslint pre-commit hook.

## Enforced Rules

### Alignment - Prettier

Function parameters and arguments should be on the same line until they surpass the max line length(80), at which point they should be aligned vertically each on their own line.
```ts
// BAD
const bar = (a,
  b,
c) => {
  ...
};

// GOOD
const bar = (a, b, c) => {
  ...
};

// BAD                                 having to scroll horizontally is shitty
const foo = (parameter, otherReallyLongParameter, superDuperLongParameter, tooManyParametersForOneLine) => {
  ...
};

// GOOD
const foo = (
  parameter,
  otherReallyLongParameter,
  superDuperLongParameter,
  tooManyParametersForOneLine
) => {
  ...
};
```

### [Arrow Function Parentheses](https://eslint.org/docs/rules/arrow-parens)

Always use parentheses around arrow function parameters, for consistency.
```ts
// BAD
const foo = x => x*x;
const lesserThings = things.map(thing => thing - 1);

// GOOD
const foo = (x) => x*x;
const lesserThings = things.map((thing) => thing -1);
```

### [Banned methods](https://github.com/remithomas/eslint-plugin-ban/blob/master/docs/rules/ban.md)

- [`fdescribe`/`fit`](https://jasmine.github.io/2.1/focused_specs.html) (focusing blocks/tests silently kills test suites' usefulness)


### [Naming Convention](https://github.com/typescript-eslint/typescript-eslint/blob/master/packages/eslint-plugin/docs/rules/naming-convention.md)
### *Class and Interface Names*

Class and Interface names should always be pascal-case for ease of identification.
```ts
// BAD
interface user {
  ...
}
class accountInfo {
  ...
}

// GOOD
interface User {
  ...
}
class AccountInfo {
  ...
}
```

### *Camel- And Pascal-Case Variable Names Only*

No leading or trailing underscores or keywords (any, Number, number, String, string, Boolean, boolean, undefined) either.
```ts
// BAD
const _pretending_im_private = false;

// GOOD
const notPretending = true;
```

### [Single-line Comments](https://eslint.org/docs/rules/spaced-comment)

There should be a space between the `//` and the first word.
```ts
//not a pleasant
//reading experience

// a much better
// reading experience
```

### [Conditional Curly Braces](https://eslint.org/docs/rules/curly)

Curly braces should always be used for `if/for/do/while` statements for clarity on what is included in the statement.
```ts
// BAD
if(thing < other)
  thing++;
  return thing;
// it's unclear whether the author knows the return
// statement is not included in the conditional block

// GOOD
if(thing < other) {
  thing++;
  return thing;
}
// OR
if(thing < other) {
  thing++;
}
return thing;


// BAD
if(foo) return true;
// it's much easier to scan for return statements
// when 'return' is the left-most word on the line

// GOOD
if(foo) {
  return true;
}
```

### [End of File Newline](https://eslint.org/docs/rules/eol-last)

End every file with a newline character, because otherwise it's [not a line](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206).

### [Indent With Spaces](https://eslint.org/docs/rules/indent#enforce-consistent-indentation-indent)

Mixing tabs and spaces is insanity, and spaces are interpreted the same universally whereas tabs are not.

### [Interface Name Prefixing](https://github.com/typescript-eslint/typescript-eslint/blob/master/packages/eslint-plugin/docs/rules/naming-convention.md#enforce-that-interface-names-do-not-begin-with-an-i)

Why mangle names to save time in differentiating an interface from a class when it's an arguably superfluous distinction in many cases.
```ts
// BAD
interface IIllusion { // kill me now please
  ...
}

// GOOD
interface Illusion {
  ...
}
```

### [Labels](https://eslint.org/docs/rules/no-unused-labels)

Labels only belong in `do/for/while/switch` statements, if at all.
```ts
// BAD
happy:
if(true) {
  console.log('happy days');
  if(condition) {
    break happy;
  }
}


// ACCEPTABLE, albeit contrived
let i = 0;
let j = 0;

loop1:
for (i = 0; i < 3; i++) {
   loop2:
   for (j = 0; j < 3; j++) {
      if (i === 1 && j === 1) {
         break loop1;
      }
      console.log(`i = ${i}, j = ${j}`);
   }
}
```

### [One Class Per File](https://eslint.org/docs/rules/max-classes-per-file)

Classes deserve their own files (which should be named after them).
```ts
// BAD
/* in file 'hurrdy-durr.ts' */
class Foo {
  ...
}
class Bar {
  ...
}


// GOOD
/* in file 'foo.ts' */
class Foo {
  ...
}

/* in file 'bar.ts' */
class Bar {
  ...
}
```
### [Class Member Ordering](https://github.com/typescript-eslint/typescript-eslint/blob/master/packages/eslint-plugin/docs/rules/member-ordering.md)

Order the members of a class consistently, for discoverability. Priority rules are:

1. fields
  1. static public
  2. static private
  3. public
  4. private
2. functions
  1. constructor
  2. static public
  3. static private
  4. public
  5. private

Members are public by default, so avoid clutter by omitting the designation.
```ts
class Alphabet {
  static a = true;
  static private b = false;

  c = true;
  private d = false;

  constructor() {
    ...
  }

  static e() {
    ...
  }

  static private f() {
    ...
  }

  g() {
    ...
  }

  private h() {
    ...
  }
}
```

### [New Parentheses](https://eslint.org/docs/rules/new-parens)

Use parentheses when invoking a constructor function with `new` for consistency with other function calls.
```ts
class Foo {
  ...
}

// BAD
const bad = new Foo;
// you'll have to use parentheses to pass arguments to other
// constructors, so use them all the time for consistency.

// GOOD
const good = new Foo();
```

### [No `arguments.callee` References](https://eslint.org/docs/rules/no-caller)

Using `arguments.callee` makes various performance optimizations impossible.
```ts
// BAD
[1, 2, 3, 4, 5].map(function(n) {
    return !(n > 1) ? 1 : arguments.callee(n - 1) * n;
});

// GOOD
const factorial = (n) => {
  return !(n > 1) ? 1 : factorial(n - 1) * n;
};

[1, 2, 3, 4, 5].map(factorial);
```

### [No Bitwise Operations](https://eslint.org/docs/rules/no-bitwise)

In most cases these are typos (i.e. `foo & bar()` when meaning `foo && bar()`) or overly clever/opaque. If there is a great reason for a bitwise operation, locally overriding the rule is fine.

### [No Conditional Assignments](https://eslint.org/docs/rules/no-cond-assign)

Like bitwise operations, these are often merely typos. If used purposefully, they're harder to notice and therefore a potential for great pain and suffering.
```ts
// BAD
let foo;

if(foo = bar) { // either a typo or someone being sneaky (a.k.a. inducing headaches)
  ...
}


// GOOD
const foo = bar;

if(foo) {
  ...
}
// OR
...
if(foo === bar) {
  ...
}
```

### [Maximum Two Consecutive Blank Lines](https://eslint.org/docs/rules/no-multiple-empty-lines)

Think of one blank line as a comma, two blank lines as a period. Three (or more) blank lines would be an exclamation point (or series of points). Exclamation points are bad.
>"One should never use exclamation points in writing. It is like laughing at your own joke." -- Mark Twain

### [No Primitive Type Constructors](https://eslint.org/docs/rules/no-new-wrappers)

In almost every case the intention of something like `new Number('0')` or `new Boolean('false')` is to perform a type conversion, not to create a wrapper object.
```ts
// BAD
const condition = new Boolean('false');
if(condition) {
  // this will always execute, because 'condition' is
  // an object (therefore truthy) regardless of content
  ...
}

// GOOD
const condition = Boolean('false');
if(condition) {
  ...
}
```

### [No Default Exports](https://github.com/import-js/eslint-plugin-import/blob/main/docs/rules/no-default-export.md)

Default exports have a tumultuous history (and present) with transiplation tooling, and naming all exports promotes clarity by disallowing the exporting of anonymous functions.
```ts
// BAD
export default function() {
  ...
};

// GOOD
export const foo = () => {
  ...
};
```

### [No Eval](https://eslint.org/docs/rules/no-eval)

Arbitrary code execution is a no-no.

### [Infer Primitive Types](https://github.com/typescript-eslint/typescript-eslint/blob/master/packages/eslint-plugin/docs/rules/no-inferrable-types.md)

Explicitly declaring types on constants assigned primitives is needless clutter.
```ts
// BAD
const foo:boolean = true;

// GOOD
const foo = true;
let bar:number = 0; // since let allows reassignment, type assertion is valid
const bazz = (buzz:boolean = false) => {
  // parameters are reassignable, so type assertion is valid (but not required)
  ...
};
```

### No Property Mutation

Avoiding property mutation makes debugging easier by limiting side effects.
```ts
// BAD
const foo = {
  bar: 1,
  baz: true,
};

foo.bar = 2;

doSomething(foo);

// GOOD
const foo = {
  bar: 1,
  baz: true,
}

const updatedFoo = {
  ...foo,
  bar: 2,
};

doSomething(updatedFoo);
```

### [No Require Imports](https://github.com/typescript-eslint/typescript-eslint/blob/master/packages/eslint-plugin/docs/rules/no-require-imports.md)

You're using a transpiler that understands ES6 import syntax, so use it.
```ts
// BAD
const foo = require('foo');

// good
import { foo } from 'foo';
```

### [No Trailing Whitespace](https://eslint.org/docs/rules/no-trailing-spaces)

Wash your hands after using the bathroom, cover your mouth when you snenoeze, and don't commit trailing whitespace for other peoples' text editors to remove bloating everyone's diffs.

### [No Unused Expressions](https://eslint.org/docs/rules/no-unused-expressions)

Unused expressions are most frequently typos.
```ts
BAD
const bar = () => {
  ...
};
bar; // no-op probably meant to be a function invocation
```

### [No Var Keyword](https://eslint.org/docs/rules/no-var)

Use `let` or `const` for greater clarity.

### [Object Literal Keys In Quotes Only When Necessary](https://eslint.org/docs/rules/quote-props)

If possible, avoid quotation marks around object literal keys to make them easier to read (less superfluous characters to parse).
```ts
// BAD
const foo = {
  'bar': true,
};

// GOOD
const foo = {
  bar: true,
  'fizz-buzz': 3,
};
```

### [Use Object Literal Shorthand](https://eslint.org/docs/rules/object-shorthand)

Reducing clutter by removing duplication.
```ts
const bar = true;
const bazz = false;

// BAD
const foo = {
  bar: bar,
  bazz: bazz,
};

// GOOD
const foo = {
  bar,
  bazz,
};
```

### [Sort Object Keys](https://eslint.org/docs/rules/sort-keys)

Sorted objects allow readers to visually binary search for keys, and helps prevent merge conflicts.
```ts
// BAD
const foo = {
  marbles: 5,
  'carrot cake': [],
  xylophone: true,
  boo: 'ahhhhhhh',
};

// GOOD
const foo = {
  boo: 'ahhhhhhh',
  'carrot cake': [],
  marbles: 5,
  xylophone: true,
};
```

### [Block Formatting](https://eslint.org/docs/rules/brace-style)
The `catch/finally/else` statements should all be on the same line as their preceding and following block braces with a single space separating them. All blocks should be at least three lines.
```ts
// BAD
if( ... ) { ... }
const foo = () => { return ... };
[...].map((x) => { return ... });
// starting/ending block braces on the same line

// GOOD
if( ... ) {
  ...
}
const foo = () => {
  return ...
};
[...].map((x) => {
  return ...
});

// BAD
if( ... ) {
  ...
}
else // not on the same line as the preceding brace or the following brace
{ ... }

// BAD
if( ... ) {
  ...
}else{ // no space between braces and 'else'
   ...
}

// GOOD
if( ... ) {
  ...
} else {
  ...
}

// BAD
try {
  ...
}catch(error){ ... } // starting/ending braces on the same line, no spaces around catch
finally { // not on the same line as the preceding brace
  ...
}

// GOOD
try {
  ...
} catch(error) {
  ...
} finally {

}
```

### [One Assignment Per Declaration Prefix](https://eslint.org/docs/rules/one-var)

Reduce diff clutter and avoid easy typos by not chaining assignments. Not enforced in `for` loops.
```ts
// BAD
const a = 5,
  b = true,
  c = null;
// removing 'c' requires changing the above comma to a semicolon. chaining
// 'd' after 'c' requires updating the semicolon to a comma. both operations
// pollute the diff and risk an easy typo headache.

// GOOD
const a = 5;
const b = true;
const c = null;
// delete any of the above or add another anywhere within/around and
// you'll always have a one line diff with no chance of a comma updating
// typo.

// OK
for(let a = 0, b = false, c; ... ; ...) {
  ...
}
```

### [Only Arrow Functions](https://github.com/TristonJ/eslint-plugin-prefer-arrow)
(After ESlint migration - this rule changed)

Traditional anonymous functions don't bind lexical scope, so their behavior can be unexpected when referencing `this`.
```ts
// BAD
const foo = {
  bar: function() {
    return this; // 'this' depends on the context in which 'bar' is called
  }
};

// GOOD
const foo = {
  bar: () => {
    return this; // 'this' will always be the context in which 'foo' was defined
  }
};
```

### [Group And Alphabetize Imports](https://github.com/import-js/eslint-plugin-import/blob/main/docs/rules/order.md)
(After ESlint migration - rule changed)

Within groups (delineated by blank lines) imports should be alphabetized, case-insensitive.
```ts
// BAD
import { ... } from 'foo';
import { ... } from 'bar';
import { ... } from 'fizz';
import { ... } from 'buzz';
import { ... } from 'aardvark';
```
```ts
// GOOD
import { ... } from 'aardvark';
import { ... } from 'bar';
import { ... } from 'buzz';
import { ... } from 'fizz';
import { ... } from 'foo';
```
```ts
// OR
import { ... } from 'buzz';
import { ... } from 'fizz';

import { ... } from 'aardvark';

import { ... } from 'bar';
import { ... } from 'foo';
```

### [Use Const Whenever Possible](https://eslint.org/docs/rules/prefer-const)

Reap the semantic benefits of your declarations; when assigning a name to a value, if that value won't/can't/shouldn't change it should use a `const` declaration, not a `let` declaration.
```ts
// BAD
const half = (value) => {
  let divisor = 2; // gives the false impression 'divisor' might change
  return value / divisor;
};

// GOOD
const half = (value) => {
  const divisor = 2;
  return value / divisor;
};
```

### [Prefer `for(... of ...)`](https://github.com/typescript-eslint/typescript-eslint/blob/master/packages/eslint-plugin/docs/rules/prefer-for-of.md)

When iterating through an array with a `for` loop, prefer the `for(... of ...)` construction over `for(let i =0; i < length; i++)` unless the index is used for something other than accessing items. `for...of` better conveys intent.
```ts
const arr = [...];

// BAD
for(let i = 0, item; i < arr.length; i++) {
  item = arr[i];
  console.log(item);
}

// GOOD
for(let item of arr) {
  console.log(item);
}
```

### [Single Quotation Marks For Strings](https://eslint.org/docs/rules/quotes)

Consistency is king, and single quotation marks are less clutter.

### [Default Switch Cases](https://eslint.org/docs/rules/default-case)

Always include a default case for switch statements either first (preferable) or last, not stuck between other cases.
```ts
// BAD
switch(foo) {
  case bar:
    return false;
  case fizz:
    return true;
}

// GOOD
switch(foo) {
  default:
    break;
  case bar:
    return false;
  case fizz:
    return true;
}
```

### [Trailing Comma (Comma dangle)](https://eslint.org/docs/rules/comma-dangle)

Always include trailing commas for the last item in multi-line object and array literals. Never for single-line literals. Your diffs will thank you.
```ts
// BAD
const foo = {
  a: true,
  b: false
};
const merp = [
  1,
  2,
  3
];
const bar = ({
  c,
  d,
  e
}) => {
  ...
};
const ugh = { x: 1, y: 2, };
const shhh = ({ quiet, time, }) => {
  ...
};

// GOOD
const foo = {
  a: true,
  b: false,
};
const merp = [
  1,
  2,
  3,
];
const bar = ({
  c,
  d,
  e,
}) => {
  ...
};
const ugh = { x: 1, y: 2 };
const shhh = ({ quiet, time }) => {
  ...
}
```

### [Triple Equals](https://eslint.org/docs/rules/eqeqeq)

[Implicit type conversion](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Equality_comparisons_and_sameness#Loose_equality_using) is not your friend. Strict comparisons are easier to reason about, so be explicit with any conversions you plan to make before comparing.
```ts
const foo = '4';
const bar = 4;

// BAD
if(foo == bar) {
  ...
}

// GOOD
if(Number(foo) === bar) {
  ...
}
```

### [Use `isNaN`](https://eslint.org/docs/rules/use-isnan)

`NaN !== NaN`, so comparing to `NaN` doesn't work.
```ts
// BAD
if(foo === NaN) {
  ...
}

// GOOD
if(isNaN(foo)) {
  ...
}
```

### Breathing Room Is Good - Prettier

Whitespace between operands, separators, and assignment precedents and antecedents promotes legibility.
```ts
// BAD
const yes = no||maybe&& 2+6;
const bar = [1,'oh god',3,false];
const foo=true;

// GOOD
const yes = no || maybe && 2 + 6;
const bar = [1, 'oh god', 3, false];
const foo = true;
```

### [No Fall-Through On Switch Statements](https://eslint.org/docs/rules/no-fallthrough)

Reasoning about switch statements making use of fall-through cases that aren't empty is hard, and often a case falling through is accidental.
```ts
// BAD
switch(foo) {
  case a:
    buzz(foo);
  case b:
    fizz(foo);
}
// what are the implications of buzz on foo given that
// fizz could be receiving it next? why is the author
// making us worry about that? did they even mean for
// that to be possible? do they hate us?

// GOOD
switch(foo) {
  case a:
    return buzz(foo);
  case b:
    return fizz(foo);
}

// OK
switch(foo) {
  case a:  
  case b:
    return buzz(foo);
    // obvious that a and b both trigger the same behavior
  case c:
    return fizz(foo);
}
```
