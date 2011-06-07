require('middleclass')

context( 'instanceof', function()

  context( 'Primitives', function()
    local o = Object:new()
    local primitives = {nil, 1, 'hello', {}, function() end}
    
    for _,primitive in pairs(primitives) do
      local theType = type(primitive)
      context('A ' .. theType, function()
        
        local f1 = function() return primitive:instanceof(Object) end
        local f2 = function() return o:instanceof(primitive) end
        local f3 = function() return primitive:instanceOf(primitive) end
        
        context('should not throw errors', function()
          test('instanceOf(Object, '.. theType ..')', function()
            assert_error(f1)
          end)
          test('instanceOf(' .. theType .. ', Object:new())', function()
            assert_error(f2)
          end)
          test('instanceOf(' .. theType .. ',' .. theType ..')', function()
            assert_error(f3)
          end)
        end)
        --[[
        test('should make instanceOf return false', function()
          assert_false(f1())
          assert_false(f2())
          assert_false(f3())
        end)
]]
      end)
    end -- for

  end)

  context( 'An instance', function()
    local Class1 = class('Class1')
    local Class2 = class('Class2', Class1)
    local Class3 = class('Class3', Class2)
    local UnrelatedClass = class('Unrelated')
    
    local o1, o2, o3 = Class1:new(), Class2:new(), Class3:new()
    
    test('should be instanceOf(Object)', function()
      assert_true(o1:instanceof(Object))
      assert_true(o2:instanceof(Object))
      assert_true(o3:instanceof(Object))
    end)
    
    test('should be instanceof its class', function()
      assert_true(o1:instanceof(Class1))
      assert_true(o2:instanceof(Class2))
      assert_true(o3:instanceof(Class3))
    end)
    
    test('should be instanceof its class\' superclasses', function()
      assert_true(o2:instanceof(Class1))
      assert_true(o3:instanceof(Class1))
      assert_true(o3:instanceof(Class2))
    end)
    
    test('should not be an instanceof its class\' subclasses', function()
      assert_false(o1:instanceof(Class2))
      assert_false(o1:instanceof(Class3))
      assert_false(o2:instanceof(Class3))
    end)
    
    test('should not be an instanceof an unrelated class', function()
      assert_false(o1:instanceof(UnrelatedClass))
      assert_false(o2:instanceof(UnrelatedClass))
      assert_false(o3:instanceof(UnrelatedClass))
    end)

  end)


end)
