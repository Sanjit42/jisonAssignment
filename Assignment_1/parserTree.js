var module = {};
module.parse = function(tree){
    if (typeof tree.leftChild !== 'number'){
        tree.leftChild = module.parse(tree.leftChild);
    }
    if (typeof tree.rightChild !== 'number'){
        tree.rightChild = module.parse(tree.rightChild);
    }
    return '('+ tree.leftChild + tree.parent + tree.rightChild+')';
};

exports.module = module;