import * as Lint from 'tslint';
import * as ts from 'typescript';

export class Rule extends Lint.Rules.AbstractRule {
  public apply(sourceFile: ts.SourceFile): Lint.RuleFailure[] {
    return this.applyWithWalker(new NoPropertyMutation(sourceFile, this.getOptions()));
  }
}

const isAssigningProperty = (node) => node.parent.left === node && node.parent.operatorToken.getText() === '=';
const accessorIsNotOnThis = (node) => node.expression.getText() !== 'this';

class NoPropertyMutation extends Lint.RuleWalker {
  public visitPropertyAccessExpression(node) {
    if (isAssigningProperty(node) && accessorIsNotOnThis(node)) {
      const errorMessage = 'Object mutation is not allowed. Please use the spread operator and create a new object';
      this.addFailure(this.createFailure(node.getStart(), node.getWidth(), errorMessage));
    }

    // call the base version of this visitor to actually parse this node
    super.walkChildren(node);
  }
}
