require('middleclass')

context( 'subclassOf', function()

  context( 'Primitives', function()
    local primitives = {nil, 1, 'hello', {}, function() end}
    
    for _,primitive in pairs(primitives) do
      local theType = type(primitive)
      context('A ' .. theType, function()
        
        local f1 = function() return primitive:inherits(Object, ) end
        local f2 = function() return o:inherits(primitive) end
        local f3 = function() return primitive:inherits(primitive) end
        
        context('should not throw errors', function()
          test('subclassOf(Object, '.. theType ..')', function()
            assert_error(f1)
          end)
          test('subclassOf(' .. theType .. ', Object:new())', function()
            assert_error(f2)
          end)
          test('subclassOf(' .. theType .. ',' .. theType ..')', function()
            assert_error(f3)
          end)
        end)
        --[[
        test('should make subclassOf return false', function()
          assert_false(f1())
          assert_false(f2())
          assert_false(f3())
        end)
]]
      end)
    end -- for
  end)
  
  context( 'Any class (except Object)', function()
    local Class1 = class('Class1')
    local Class2 = class('Class2', Class1)
    local Class3 = class('Class3', Class2)
    local UnrelatedClass = class('Unrelated')
    
    test('should be subclassOf(Object)', function()
      assert_true(Class1:inherits(Object))
      assert_true(Class1:inherits(Object))
      assert_true(Class1:inherits(Object))
    end)
    
    test('should be subclassOf its direct superclass', function()
      assert_true(Class2:inherits(Class1))
      assert_true(Class3:inherits(Class2))
    end)
    
    test('should be subclassOf its ancestors', function()
      assert_true(Class3:inherits(Class1))
    end)
    
    test('should not be an subclassOf its class\' subclasses', function()
      assert_false(Class1:inherits(Class2))
      assert_false(Class1:inherits(Class3))
      assert_false(Class2:inherits(Class3))
    end)
    
    test('should not be an subclassOf an unrelated class', function()
      assert_false(Class1:inherits(UnrelatedClass))
      assert_false(Class2:inherits(UnrelatedClass))
      assert_false(Class3:inherits(UnrelatedClass))
    end)

  end)

end)
