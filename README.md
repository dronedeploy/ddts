# ddts

A style guide for writing better typescript, enforced via tslint pre-commit hook.

## Enforced Rules

### [Alignment](https://palantir.github.io/tslint/rules/align/)

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

### [Arrow Function Parentheses](https://palantir.github.io/tslint/rules/arrow-parens/)

Always use parentheses around arrow function parameters, for consistency.
```ts
// BAD
const foo = x => x*x;
const lesserThings = things.map(thing => thing - 1);

// GOOD
const foo = (x) => x*x;
const lesserThings = things.map((thing) => thing -1);
```

### [Class and Interface Names](https://palantir.github.io/tslint/rules/class-name/)

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

### [Single-line Comments](https://palantir.github.io/tslint/rules/comment-format/)

There should be a space between the `//` and the first word.
```ts
//not a pleasant
//reading experience

// a much better
// reading experience
```

### [Conditional Curly Braces](https://palantir.github.io/tslint/rules/curly/)

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

### [End of File Newline](https://palantir.github.io/tslint/rules/eofline/)

End every file with a newline character, because otherwise it's [not a line](http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap03.html#tag_03_206).

### [Indent With Spaces](https://palantir.github.io/tslint/rules/indent/)

Mixing tabs and spaces is insanity, and spaces are interpreted the same universally whereas tabs are not.

### [Interface Name Prefixing](https://palantir.github.io/tslint/rules/interface-name/)

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

### [Labels](https://palantir.github.io/tslint/rules/label-position/)

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

### [One Class Per File](https://palantir.github.io/tslint/rules/max-classes-per-file/)

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
### [Class Member Ordering](https://palantir.github.io/tslint/rules/member-ordering/)

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

### [New Parentheses](https://palantir.github.io/tslint/rules/new-parens/)

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

### [No `arguments.callee` References](https://palantir.github.io/tslint/rules/no-arg/)

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

### [No Bitwise Operations](https://palantir.github.io/tslint/rules/no-bitwise/)

In most cases these are typos (i.e. `foo & bar()` when meaning `foo && bar()`) or overly clever/opaque. If there is a great reason for a bitwise operation, locally overriding the rule is fine.

### [No Conditional Assignments](https://palantir.github.io/tslint/rules/no-conditional-assignment/)

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

### [Maximum Two Consecutive Blank Lines](https://palantir.github.io/tslint/rules/no-consecutive-blank-lines/)

Think of one blank line as a comma, two blank lines as a period. Three (or more) blank lines would be an exclamation point (or series of points). Exclamation points are bad.
>"One should never use exclamation points in writing. It is like laughing at your own joke." -- Mark Twain

### [No Primitive Type Constructors](https://palantir.github.io/tslint/rules/no-construct/)

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

### [No Default Exports](https://palantir.github.io/tslint/rules/no-default-export/)

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

### [No Eval](https://palantir.github.io/tslint/rules/no-eval/)

Arbitrary code execution is a no-no.

### [Infer Primitive Types](https://palantir.github.io/tslint/rules/no-inferrable-types/)

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

### [No Magic Numbers](https://palantir.github.io/tslint/rules/no-magic-numbers/)

Forcing numbers to be stored in variables makes them self document. Exempt numbers are -1, 0, 1, and 2 because most of the time their purpose is obvious enough.
```ts
// BAD
for(let i = 0, i < 382; i++) {
  // Only God knows the significance of 382, because
  // Barry quit in a fit of rage last month and he
  // didn't believe in documentation
  ...
}

// GOOD
const userCount = 382;
for(let i = 0; i < userCount; i++) {
  ...
}

// OK
const duos = userCount / 2;

if(users.indexOf('Jane') === -1) {
  ...
}
```

### [No Require Imports](https://palantir.github.io/tslint/rules/no-require-imports/)

You're using a transpiler that understands ES6 import syntax, so use it.
```ts
// BAD
const foo = require('foo');

// good
import { foo } from 'foo';
```

## [No Fall-Through On Switch Statements](https://palantir.github.io/tslint/rules/no-switch-case-fall-through/)

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

### [No Trailing Whitespace](https://palantir.github.io/tslint/rules/no-trailing-whitespace/)

Wash your hands after using the bathroom, cover your mouth when you sneaze, and don't commit trailing whitespace for other peoples' text editors to remove bloating everyone's diffs.

### [No Unused Expressions](https://palantir.github.io/tslint/rules/no-unused-expression/)

Unused expressions are most frequently typos.
```ts
BAD
const bar = () => {
  ...
};
bar; // no-op probably meant to be a function invocation
```

### [No Unused New](https://palantir.github.io/tslint/rules/no-unused-new/)

Constructing an object for its creation side effects is confusing. Refactor the object to make its purpose more explicit.
```ts
// BAD
class Foo {
  constructor() {
    this.doSomethingImportant();
  }

  doSomethingImportant() {
    ...
  }
}

new Foo();


// GOOD
class Foo {
  doSomethingImportant() {
    ...
  }
}

const bar = new Foo();
bar.doSomethingImportant();
```

### [No Var Keyword](https://palantir.github.io/tslint/rules/no-var-keyword/)

Use `let` or `const` for greater clarity.

### [Object Literal Keys In Quotes Only When Necessary](https://palantir.github.io/tslint/rules/object-literal-key-quotes/)

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

### [Use Object Literal Shorthand](https://palantir.github.io/tslint/rules/object-literal-shorthand/)

Reducing clutter by removing duplicatation.
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

### [Sort Object Keys](https://palantir.github.io/tslint/rules/object-literal-sort-keys/)

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

### [Block Formatting](https://palantir.github.io/tslint/rules/one-line/)
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

### [One Assignment Per Declaration Prefix](https://palantir.github.io/tslint/rules/one-variable-per-declaration/)

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

### [Only Arrow Functions](https://palantir.github.io/tslint/rules/only-arrow-functions/)

Traditional annonymous functions don't bind lexical scope, so their behavior can be unexpected when referencing `this`.
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
    return this; 'this' will always be the context in which 'foo' was defined
  }
};
```

### [Group And Alphabetize Imports](https://palantir.github.io/tslint/rules/ordered-imports/)

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

### [Use Const Whenever Possible]()

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

### [Prefer `for(... of ...)`](https://palantir.github.io/tslint/rules/prefer-for-of/)

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

### [Double Quotation Marks For Strings](https://palantir.github.io/tslint/rules/quotemark/)

Consistency is king, and double quotation marks allow the use of a single quotation mark as an apostrophe without escaping.

### [Default Switch Cases](https://palantir.github.io/tslint/rules/switch-default/)

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

### [Trailing Commas](https://palantir.github.io/tslint/rules/trailing-comma/)

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

### [Triple Equals](https://palantir.github.io/tslint/rules/triple-equals/)

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

### [Use `isNaN`](https://palantir.github.io/tslint/rules/use-isnan/)

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

### [Camel- And Pascal-Case Variable Names Only](https://palantir.github.io/tslint/rules/variable-name/)

No leading or trailing underscores or keywords (any, Number, number, String, string, Boolean, boolean, undefined) either.
```ts
// BAD
const _pretending_im_private = false;

// GOOD
const notPretending = true;
```

### [Breathing Room Is Good](https://palantir.github.io/tslint/rules/whitespace/)

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
