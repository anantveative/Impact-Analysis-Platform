<?php
/**
 * @license   http://opensource.org/licenses/BSD-3-Clause BSD-3-Clause
 * @copyright Copyright (c) 2014 Zend Technologies USA Inc. (http://www.zend.com)
 */

namespace ZFTest\MvcAuth\Factory;

use PHPUnit_Framework_TestCase as TestCase;
use ZF\MvcAuth\Factory\HttpAdapterFactory;

class HttpAdapterFactoryTest extends TestCase
{
    private $htpasswd;
    private $htdigest;

    public function setUp()
    {
        $this->htpasswd = __DIR__ . '/../TestAsset/htpasswd';
        $this->htdigest = __DIR__ . '/../TestAsset/htdigest';
    }

    public function testFactoryRaisesExceptionWhenNoAcceptSchemesPresent()
    {
        $this->setExpectedException(
            'Zend\ServiceManager\Exception\ServiceNotCreatedException',
            'accept_schemes'
        );
        HttpAdapterFactory::factory(array());
    }

    public function invalidAcceptSchemes()
    {
        return array(
            'null' => array(null),
            'true' => array(true),
            'false' => array(false),
            'zero' => array(0),
            'int' => array(1),
            'zerofloat' => array(0.0),
            'float' => array(1.1),
            'string' => array('basic'),
            'object' => array((object) array('basic')),
        );
    }

    /**
     * @dataProvider invalidAcceptSchemes
     */
    public function testFactoryRaisesExceptionWhenAcceptSchemesIsNotAnArray($acceptSchemes)
    {
        $this->setExpectedException(
            'Zend\ServiceManager\Exception\ServiceNotCreatedException',
            'accept_schemes'
        );
        HttpAdapterFactory::factory(array('accept_schemes' => $acceptSchemes));
    }

    public function testFactoryRaisesExceptionWhenRealmIsMissing()
    {
        $this->setExpectedException(
            'Zend\ServiceManager\Exception\ServiceNotCreatedException',
            'realm'
        );
        HttpAdapterFactory::factory(array(
            'accept_schemes' => array('basic'),
        ));
    }

    public function testRaisesExceptionWhenDigestConfiguredAndNoDomainsPresent()
    {
        $this->setExpectedException(
            'Zend\ServiceManager\Exception\ServiceNotCreatedException',
            'digest_domains'
        );
        HttpAdapterFactory::factory(array(
            'accept_schemes' => array('digest'),
            'realm' => 'api',
            'nonce_timeout' => 3600,
        ));
    }

    public function testRaisesExceptionWhenDigestConfiguredAndNoNoncePresent()
    {
        $this->setExpectedException(
            'Zend\ServiceManager\Exception\ServiceNotCreatedException',
            'digest_domains'
        );
        HttpAdapterFactory::factory(array(
            'accept_schemes' => array('digest'),
            'realm' => 'api',
            'digest_domains' => 'https://example.com',
        ));
    }

    public function validConfigWithoutResolvers()
    {
        return array(
            'basic' => array(array(
                'accept_schemes' => array('basic'),
                'realm' => 'api',
            )),
            'digest' => array(array(
                'accept_schemes' => array('digest'),
                'realm' => 'api',
                'digest_domains' => 'https://example.com',
                'nonce_timeout' => 3600,
            )),
            'both' => array(array(
                'accept_schemes' => array('basic', 'digest'),
                'realm' => 'api',
                'digest_domains' => 'https://example.com',
                'nonce_timeout' => 3600,
            )),
        );
    }

    /**
     * @dataProvider validConfigWithoutResolvers
     */
    public function testCanReturnAdapterWithNoResolvers($config)
    {
        $adapter = HttpAdapterFactory::factory($config);
        $this->assertInstanceOf('Zend\Authentication\Adapter\Http', $adapter);
        $this->assertNull($adapter->getBasicResolver());
        $this->assertNull($adapter->getDigestResolver());
    }

    public function testCanReturnBasicAdapterWithApacheResolver()
    {
        $adapter = HttpAdapterFactory::factory(array(
            'accept_schemes' => array('basic'),
            'realm' => 'api',
            'htpasswd' => $this->htpasswd,
        ));

        $this->assertInstanceOf('Zend\Authentication\Adapter\Http', $adapter);
        $this->assertInstanceOf('Zend\Authentication\Adapter\Http\ApacheResolver', $adapter->getBasicResolver());
        $this->assertNull($adapter->getDigestResolver());
    }

    public function testCanReturnDigestAdapterWithFileResolver()
    {
        $adapter = HttpAdapterFactory::factory(array(
            'accept_schemes' => array('digest'),
            'realm' => 'api',
            'digest_domains' => 'https://example.com',
            'nonce_timeout' => 3600,
            'htdigest' => $this->htdigest,
        ));

        $this->assertInstanceOf('Zend\Authentication\Adapter\Http', $adapter);
        $this->assertNull($adapter->getBasicResolver());
        $this->assertInstanceOf('Zend\Authentication\Adapter\Http\FileResolver', $adapter->getDigestResolver());
    }

    public function testCanReturnCompoundAdapter()
    {
        $adapter = HttpAdapterFactory::factory(array(
            'accept_schemes' => array('basic', 'digest'),
            'realm' => 'api',
            'digest_domains' => 'https://example.com',
            'nonce_timeout' => 3600,
            'htpasswd' => $this->htpasswd,
            'htdigest' => $this->htdigest,
        ));

        $this->assertInstanceOf('Zend\Authentication\Adapter\Http', $adapter);
        $this->assertInstanceOf('Zend\Authentication\Adapter\Http\ApacheResolver', $adapter->getBasicResolver());
        $this->assertInstanceOf('Zend\Authentication\Adapter\Http\FileResolver', $adapter->getDigestResolver());
    }

    public function testCanReturnBasicAdapterWithCustomResolverFromServiceManager()
    {
        $keyForServiceManager = 'keyForServiceManager';

        $serviceManager = $this->getMock('\Zend\ServiceManager\ServiceLocatorInterface');
        $serviceManager
            ->expects($this->once())
            ->method('has')
            ->with($keyForServiceManager)
            ->will($this->returnValue(true));

        $resolver = $this->getMock('\Zend\Authentication\Adapter\Http\ResolverInterface');
        $serviceManager
            ->expects($this->once())
            ->method('get')
            ->with($keyForServiceManager)
            ->will($this->returnValue($resolver));

        $adapter = HttpAdapterFactory::factory(array(
            'accept_schemes' => array('basic', 'digest'),
            'realm' => 'api',
            'digest_domains' => 'https://example.com',
            'nonce_timeout' => 3600,
            'htpasswd' => $this->htpasswd,
            'basic_resolver_factory' => $keyForServiceManager,
        ), $serviceManager);

        $this->assertInstanceOf('Zend\Authentication\Adapter\Http', $adapter);
        $this->assertSame($resolver, $adapter->getBasicResolver());
        $this->assertNull($adapter->getDigestResolver());
    }

    public function testCanReturnDigestAdapterWithCustomResolverFromServiceManager()
    {
        $keyForServiceManager = 'keyForServiceManager';

        $serviceManager = $this->getMock('\Zend\ServiceManager\ServiceLocatorInterface');
        $serviceManager
            ->expects($this->once())
            ->method('has')
            ->with($keyForServiceManager)
            ->will($this->returnValue(true));

        $resolver = $this->getMock('\Zend\Authentication\Adapter\Http\ResolverInterface');
        $serviceManager
            ->expects($this->once())
            ->method('get')
            ->with($keyForServiceManager)
            ->will($this->returnValue($resolver));

        $adapter = HttpAdapterFactory::factory(array(
            'accept_schemes' => array('basic', 'digest'),
            'realm' => 'api',
            'digest_domains' => 'https://example.com',
            'nonce_timeout' => 3600,
            'htdigest' => $this->htdigest,
            'digest_resolver_factory' => $keyForServiceManager,
        ), $serviceManager);

        $this->assertInstanceOf('Zend\Authentication\Adapter\Http', $adapter);
        $this->assertNull($adapter->getBasicResolver());
        $this->assertSame($resolver, $adapter->getDigestResolver());
    }

    public function testCanReturnAdapterWithNoResolversAndInvalidServiceManager()
    {
        $adapter = HttpAdapterFactory::factory(array(
            'accept_schemes' => array('basic', 'digest'),
            'realm' => 'api',
            'digest_domains' => 'https://example.com',
            'nonce_timeout' => 3600,
            'basic_resolver_factory' => 'uselessKeyDueToMissingServiceManager',
            'digest_resolver_factory' => 'uselessKeyDueToMissingServiceManager',
        ));

        $this->assertInstanceOf('Zend\Authentication\Adapter\Http', $adapter);
        $this->assertNull($adapter->getBasicResolver());
        $this->assertNull($adapter->getDigestResolver());
    }

    public function testCanReturnAdapterWithNoResolversAndInvalidResolverKeys()
    {
        $serviceManager = $this->getMock('\Zend\ServiceManager\ServiceLocatorInterface');
        $serviceManager->expects($this->never())->method('has');

        $adapter = HttpAdapterFactory::factory(array(
            'accept_schemes' => array('basic', 'digest'),
            'realm' => 'api',
            'digest_domains' => 'https://example.com',
            'nonce_timeout' => 3600,
            'basic_resolver_factory' => null,
            'digest_resolver_factory' => array(),
        ), $serviceManager);

        $this->assertInstanceOf('Zend\Authentication\Adapter\Http', $adapter);
        $this->assertNull($adapter->getBasicResolver());
        $this->assertNull($adapter->getDigestResolver());
    }

    public function testCanReturnAdapterWithNoResolversAndMissingServiceManagerEntries()
    {
        $missingKeyForServiceManager = 'missingKeyForServiceManager';

        $serviceManager = $this->getMock('\Zend\ServiceManager\ServiceLocatorInterface');
        $serviceManager
            ->expects($this->any())
            ->method('has')
            ->with($missingKeyForServiceManager)
            ->will($this->returnValue(false));
        $serviceManager
            ->expects($this->never())
            ->method('get');

        $adapter = HttpAdapterFactory::factory(array(
            'accept_schemes' => array('basic', 'digest'),
            'realm' => 'api',
            'digest_domains' => 'https://example.com',
            'nonce_timeout' => 3600,
            'basic_resolver_factory' => $missingKeyForServiceManager,
            'digest_resolver_factory' => $missingKeyForServiceManager,
        ), $serviceManager);

        $this->assertInstanceOf('Zend\Authentication\Adapter\Http', $adapter);
        $this->assertNull($adapter->getBasicResolver());
        $this->assertNull($adapter->getDigestResolver());
    }
}