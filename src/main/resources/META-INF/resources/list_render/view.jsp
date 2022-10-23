<%--
/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
--%>

<%@ include file="/init.jsp" %>

<%
	CommerceContext commerceContext = (CommerceContext)request.getAttribute(CommerceWebKeys.COMMERCE_CONTEXT);
	CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);
	CPDataSourceResult cpDataSourceResult = (CPDataSourceResult)request.getAttribute(CPWebKeys.CP_DATA_SOURCE_RESULT);

	long commerceAccoountId = commerceContext.getCommerceAccount().getCommerceAccountId();

	List<CPCatalogEntry> cpCatalogEntries = cpDataSourceResult.getCPCatalogEntries();


%>

<c:choose>
	<c:when test="<%= !cpCatalogEntries.isEmpty() %>">
		<div class="minium-product-tiles">

			<%
			for (CPCatalogEntry cpCatalogEntry : cpCatalogEntries) {

				String productFriendlyUrl = cpContentHelper.getFriendlyURL(cpCatalogEntry, themeDisplay);
				CPSku cpSku = cpContentHelper.getDefaultCPSku(cpCatalogEntry);
				String addToCartId = PortalUtil.generateRandomKey(request, "add-to-cart");
				long cpDefinitionId = cpCatalogEntry.getCPDefinitionId();
				String productDefaultImageUrl = cpContentHelper.getDefaultImageFileURL(commerceAccoountId, cpDefinitionId);
				String signInUrl = "/c/portal/login?redirect=" + productFriendlyUrl;
				String productDetailURL = cpContentHelper.getFriendlyURL(cpCatalogEntry, themeDisplay);

			%>

				<%@ include file="/list_render/product_tile.jspf" %>

			<%
			}
			%>

		</div>
	</c:when>
	<c:otherwise>
		<div class="alert alert-info">
			<liferay-ui:message key="no-products-were-found" />
		</div>
	</c:otherwise>
</c:choose>